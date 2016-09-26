# Vima

**Vima** is a video manager or video library. It manages a set of videos and allows the user to define custom metadata for each video. The user can then properly search for specific videos via the specified metadata using a custom query language.

This application takes a lot of inspiration from Plex Media Server as the frustration with some parts led to creating Vima.

## What is the problem with Plex / other media servers?

Plex is, for most people, a really good media server and serves their needs well. Because an average user mostly has a video collection at home that is primarily movies. Plex is great for that because it automatically gets all the details for each movie from the web and there's nothing really to add.

The problem arises when you have a giant collection and want to search _properly_. Plex's search is based on a logical OR which makes any specific query useless. Other than that, the search is what you'd expect. Waiting for Plex to add this feature would be one way, but I need this feature in order to use a media server / video manager.

Moreover, Plex is really lacking when it comes to customization of metadata. You can only use the already pre-defined fields from Plex and combined with the missing _AND_ connection, you can't really find the things you're actually looking for.

## My Solution

This project is my attempt to solve this dilemma. To at some point have a working solution, the scope of the project is very limited and will not come close to what Plex or other offer except for the mentioned pain points.

Vima's basic concept is that a video does not get any metadata from the system itself, but the user has to define everything that one could assign. The user can chose to let the system provide some metadata, but that has to be configured as well. All metadata fields can then be edited by the user to his liking and can be of different types. Such types include: Number range, Simple number, value list, text, boolean and tag list. The query language helps to allow the user to find the exact video(s) he's searching for.