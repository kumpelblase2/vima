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

After you go over the configuration, you can start Vima using `bin/rails server`.

## Configuration

TODO

## Contributing

TODO

## Internal TODO

- Improving video metadata display
- Allow for keeping video in fullscreen when switching to next one in playlist
