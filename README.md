# BallotBoxDJ
Welcome to BallotBoxDJ!

BallotBoxDJ is an application currently under development for iOS. The objective of this app is to utilize the Spotify SDK to manipulate the playback of songs within a playlist on a single iPhone device (the host) from the consensus of a desired group of users (the guests) based on a nomination process and voting mechanism. The nominating and voting takes place in a room created by the host which is a server that guests can connect to with a room code or QR code.



## Screenshots

<div>
  <img src="https://github.com/jpferner/BallotBoxDJ/blob/develop/screenshots/section-view.png?raw=true" width=25% height=25%/ style="display: block; margin: 20px;">
  
  <img src="https://github.com/jpferner/BallotBoxDJ/blob/develop/screenshots/section-view-votes.png?raw=true" width=25% height=25%/ style="display: block; margin: 20px;">
</div>

*Screenshots of GuestSectionView.swift which is displayed to the user after they have entered a room as a host or a guest.*


## Features

### Current Features

- **Responsive UI**: The room UI is responsive and works on all iPhone devices.
- **Nomination Process**: The room nominates two new songs from the host's current playlist every time a song has finished playing.
- **Voting Mechanism**: The room selects and queues the next song to be played on the host's device based on a tally of votes between the two nominated songs and a random option for all members of the room.
- **Room Code**: Guests can enter a room with a numerical room code which the host has access to.
- **Room Chat**: The room provides a real time chat service its members.

### Planned Features

- **QR code**
- **Host/Guest Settings**
- **Nomination Queue**
- **Playlist Queue**
- **External Song Link**
