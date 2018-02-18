# Vima

**Vima** is a video manager or video library. It manages a set of videos and allows the user to define custom metadata for each video. The user can then properly search for specific videos via the specified metadata using a custom query language.

This application takes a lot of inspiration from Plex Media Server as the frustration with some parts led to creating Vima.

## What is the problem with Plex / other media servers?

Plex is, for most people, a really good media server and serves their needs well. Because an average user mostly has a video collection at home that is primarily movies. Plex is great for that because it automatically gets all the details for each movie from the web and there's nothing really to add.

The problem arises when you have a giant collection and want to search _properly_. Plex's search is based on a logical OR which makes any specific query useless. Other than that, the search is what you'd expect. Waiting for Plex to add this feature would be one way, but I need this feature in order to use a media server / video manager.

Moreover, Plex is really lacking when it comes to customization of metadata. You can only use the already pre-defined fields from Plex(*) and combined with the missing _AND_ connection, you can't really find the things you're actually looking for.

## My Solution

This project is my attempt to solve this dilemma. To at some point have a working solution, the scope of the project is very limited and will not come close to what Plex or other offer except for the mentioned pain points.

Vima's basic concept is that a video does not get any metadata from the system itself, but the user has to define everything that one could assign. The user can chose to let the system provide some metadata, but that has to be configured as well. All metadata fields can then be edited by the user to his liking and can be of different types. Such types include: Number range, Simple number, value list, text, boolean and tag list (and more). The query language helps to allow the user to find the exact video(s) he's searching for.

(*): There are also some stupid things with metadata in plex. Some metadata will be pulled from the file metadata, but is not visible/editable in the UI (like Cast of a Movie). Others are there, but cannot be searched for (there's a 'Rating' when editing a video, but it's not the same field as 'Rating' in the search).

## Assumptions

These are assumptions that I made when developing this project. This is not to say that my goal is to specifically target these, but if there's a decision to be made, it'll be made with these assumptions in mind (e.g.: available APIs).

- Modern Browser (e.g. FF 59 or Chrome 60)
- Served locally or intranet (not internet)
- files are on a local drive (not network share)
- Desktop focus
- Single library

If you do not agree with one or more of these assumptions, feel free to submit a PR that adapts the current behavior to allow for different setups or just fork it.

## Internal TODO

- Ordering of video in playlist
- Improving video metadata display
- Allow for keeping video in fullscreen when switching to next one in playlist
