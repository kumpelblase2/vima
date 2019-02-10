# Vima

**Vima** is a video manager or video collection. It manages a set of videos and allows the user to define custom metadata for each video. The user can then search for specific videos via the specified metadata using a custom query language, create playlists the same way and obviously play the videos in their browser.

This application takes a lot of inspiration from the Plex Media Server as the frustration with certain parts led to the creation of Vima.

## What is the problem with Plex / other media servers?

Plex is, for most people, a really good media server and serves their needs well. Because an average user mostly has a video collection at home that is primarily movies and tv shows. Plex is great for that because it automatically gets all the details for each movie from the web and there's nothing really to add.

The problem arises when you have a giant collection of videos that are not as neatly indexed and you want to search those _properly_. Plex' search used to be pretty horrible, only providing OR connections and being in general very limited, but Plex actually improved in this regard. However, it's still nowhere near the complexity I want since it's now a bunch of ANDs where you can only do an OR for each property, not freely combine ANDs and ORs.

Moreover, Plex is really lacking when it comes to customization of metadata. You can only use the already pre-defined fields from Plex(*) and combined with the lacking search, you can't really find the things you're actually looking for.

(*): There are also some stupid things with metadata in plex. Some metadata will be pulled from the file metadata, but is not visible/editable in the UI (like Cast of a Movie). Others are there, but cannot be searched for (there's a 'Rating' when editing a video, but it's not the same field as 'Rating' in the search).

## Other Solutions

There are certainly other media servers available, but they pretty much just mirror Plex when it comes to functionality. They all manage a library of movies/shows which have a fixed metadata which they receive from some supplier (usually some agent pulling stuff from imbd or the like). As far as I can tell, I haven't found _any_ software that allowed specifying custom metadata let alone searching on that. 

## My Solution

This project is my attempt to solve this dilemma. To, at some point, have a working solution, the scope of the project is very limited and will not come close to what Plex or other offer except for the mentioned pain points.

Vima's basic concept is that a video does not get any metadata from the system itself, but the user has to define everything that one could assign. The user can chose to let the system provide some metadata automatically by means of "metadata providers", but that has to be configured as well. All metadata fields can then be edited by the user to his liking and can be of different types. Such types include: Number range, Simple number, value list, text, boolean and tag list (and more). The query language helps to allow the user to find the exact video(s) he's searching for.

## Assumptions

These are assumptions that I made when developing this project. This is not to say that my goal is to specifically target these, but if there's a decision to be made, it'll be made with these assumptions in mind (e.g.: available APIs).

- Modern Browser (e.g. FF 64 or Chrome 70)
- Served locally or internal network (not internet)
- files are on a local drive (not network share)
- Desktop focus
- Single library

If you do not agree with one or more of these assumptions, feel free to submit a PR that adapts the current behavior to allow for different setups or just fork it.

## Setup

If you want to run Vima, you need the following:

- Ruby (and the bundler gem installed)
- MongoDB
- ffmpeg

Once these are installed, clone this repository to a place you like. After the cloning is finished, switch into the directory and install the dependencies using bundler:

```
$ bundle install --path vendor
```

After you go over the configuration, you can start Vima using `bin/rails s -e production`.

## Configuration

There are two main configuration files that you may want to adjust. First one being `config/mongoid.yml` which contains the information necessary to connect to the mongodb instance. Specifically, you would want to adjust the database name, host+port, user and password to your current configuration.

You also want to adjust `config/library.yml` as this is the main description of your library. It looks like this:

```yaml
production:
  dir: /path/to/videos # absolute location of videos
  defaults:
    order_by: name # Default Attribute to order by
    order_direction: asc # Default Ordering Direction
  home:
    videos: 12 # Amount of videos to show on landing page
  thumbnails:
    amount: 4 # Amount of thumbnails to generate
    dir: ".thumbnails" # relative directory for storing thumbnails
  playlist:
    display: # Which attributes should be displayed when watching videos in a playlist
     - bitrate
     - length
  metadata:
    # Custom Metadata that can be assigned to each video (see below)  
  providers:
    # Providers by the system that should be applied (see below)
```

### Metadata

Every metadata attribute consists of two or three things; the name, it's type and optionally any options. The names are usually all lowercase, and use an underscore (`_`) instead of a space, but will be converted automatically. So metadata with the name `contact_person` well be shown as `Contact Person`.

There are several kinds of metadata:
- `number` (Just a simple whole number)
- `on_off` (Checkbox for true/false)
- `text` (Plain text input)
- `range` (Range of numbers, e.g. 0-10)
- `select` (An element out of a selection of predefined values)
- `taglist` (A list of user-defined tags)
- `date` (A date)
- `duration` (A time duration)

You can define any number of these with any name, ordering or options you like. Not all types have options, the possible ones are listed below:

- `number` / `duration` / `range` have `min`, `max`, `step`
- `select` has `values`

There are two ways of defining metadata. The short variant (without options) or the long variant (with options).
Short variant:

```yaml
production:
  # ...
  metadata:
    - notes: text
```

The above defines metadata of type `text` with the name `notes`. A text metadata attribute does not have any options so this works fine, but for a `select` it would look like this:

```yaml
production:
  # ...
  metadata:
    - name: license
      type: select
      options:
        values:
          - CC0
          - No license
          - CCBYSA
``` 

Which would create metadata of type `select` with the name `license` and allows for selecting one value from "CC0", "No license" or "CCBYSA". Please note that the first entry will be the default when editing a video.

#### Default Ordering

The application allows you to order videos when listing them. To make it less of a hassle to get the more common ordering for a certain metadata attribute, you may also define the default ordering direction. This can be done by specifying the `ordering` when defining the metadata:

```yaml
production:
  # ...
  metadata:
    - name: publish_year
      type: number
      ordering: desc
      options:
        # ...
``` 

### Metadata providers

Certain metadata can be provided by the system itself, if so desired. Such as the metadata stored inside the video itself, e.g. the length, bitrate, and resolution. However, metadata providers can also provide metadata that automatically adapts, such as a counting version, a pointing system, or watch counter. Usually these are read only as they are facts (such as bitrate), but not all of them are.

These are the currently existing metadata providers:

- `VideoVersion`
- `VideoMetadata`
- `WatchedStatus`
- `PointsProvider`

`VideoVersion` provides a `version` metadata attribute that gets counted up every time the video gets edited by the user.

`VideoMetadata` provides `length`, `resolution`, `bitrate` from the video using ffmpeg. `resolution` is one of "SD", "480p", "720p" or "1080p".

`WatchedStatus` adds metadata attributes relating to how often, when was the first and last time you watched a video and how far have you watched a video. These are `watched` (if the video has been watched), `watched_times` (the amount of times it has been watched), `last_watched` (the last time it has been watched), `first_watched` (the first time it has been watched), `added_date` (the day the video was added), and `last_watched_progress` (tracks the location you stopped watching and starts from there the next time you watch the video)

## Contributing

Feel free to contribute any kind of improvement, may that be wording, translation, UI/UX, new metadata provider, bug fixes or better documentation. This is a hobby project for me so time is a little limited and thus any help is appreciated. 

## Internal TODO

- Improving video metadata display
- Allow for keeping video in fullscreen when switching to next one in playlist
