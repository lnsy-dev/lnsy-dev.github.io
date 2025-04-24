---
layout: post
title: Montage Organ
date: 2025-04-23 17:31:09 -0700
categories: blog
created: 2025-04-23T17:31
updated: 2025-04-23T17:48
tags:
  - vj
  - code
  - webdev
  - multi-media
---
[Play the Montage Organ Here](https://lnsy-dev.github.io/montage-organ/montage-organ.html)

This is a fun VJ framework I built. It works well with MIDI instruments and OBS streaming. It's a way to edit a movie while you write the soundtrack at the same time. I showed a movie buff friend and they deemed what I was doing "True Cinema". 

It has a really simple concept for determining which part of the videos it represents. The lowest note the software has received will always go to the beginning of the video, and the highest note the software has received will always go to the end of the video. This means the edit points of the video change as the range of the piece expand. I consider it a feature, not a bug. 

I strongly recommend you read the code -- you will be impressed by its simplicity. 

```html
<!--

  #     # ####### #     # #######    #     #####  #######
  ##   ## #     # ##    #    #      # #   #     # #
  # # # # #     # # #   #    #     #   #  #       #
  #  #  # #     # #  #  #    #    #     # #  #### #####
  #     # #     # #   # #    #    ####### #     # #
  #     # #     # #    ##    #    #     # #     # #
  #     # ####### #     #    #    #     #  #####  #######

  ####### ######   #####     #    #     #
  #     # #     # #     #   # #   ##    #
  #     # #     # #        #   #  # #   #
  #     # ######  #  #### #     # #  #  #
  #     # #   #   #     # ####### #   # #
  #     # #    #  #     # #     # #    ##
  ####### #     #  #####  #     # #     #

  By LNSY

  You ever read old texts? They always start with some long winded introduction. 
  HTML is really no different. 
  The following just describes to the computer what I'm showing it. 
  You can mostly skip it until the next block of text that looks like this.

-->


<!DOCTYPE html>
<html>
<head>
  <title>Montage Organ</title>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
  <meta name="description" content="Simple VJ Software">
  <style>
    body {
      background-color: black;
      color: white;
      font-family: monospace;
    }
    input {
      position: absolute;
      left: 50%;
      top: 50%;
      transform: translate(-50%, -50%);
    }
    video {
      position: fixed;
      left: 0px;
      top: 0px;
      min-width: 100%;
      width:auto;
      height: auto;
      min-height: 100%;
      z-index:-1;
    }
    li:first-child{
      list-style: none
    }
  </style>
</head>

<!--

  The next section is what the user sees, 
  or rather what their browser renders,
  but let's not go so far into the deep end right away. 

!-->
<body>


<div id="introduction">
  <ul>
    <li><h1>Montage Organ</h1></li>
    <li>Use the file select below to select an MP4 file</li>
    <li>Use any MIDI Device to play the movie like a sampler</li>
    <li>You can also control it with you computer keyboard</li>
    <li>Press spacebar to pause the movie</li>
    <li>If you want to use a different movie, reload the page</li>
    <li>With a Linux Thinkpad running Chrome, my Roland GR-55 just works, but my OP-1 Requires me to switch between modes first to work. I have no other devices to test with. YMMV.</li>
    <li><a href="https://lindseymysse.com/" target="_blank">Stop by to say hi sometime</a></li>
    <li><a href="https://github.com/lindseymysse/montage-organ/blob/main/montage-organ.html" target="_blank">Read my code! It's not that much but you can do a whole lot with it.</a></li>
    <li><a href="https://archive.org/details/max-headroom-complete" target="_blank">Looking for some source material?</a></li>
  </ul>
</div>

<!-- 


  This is where the real code starts. 
  We have two elements: an input and a video. 
  When the user selects an new file the application kicks off.

  You can use CSS filters on the video element to customize your VJ set. 
  https://developer.mozilla.org/en-US/docs/Web/CSS/filter
  Replace the video element below with something that looks like: 

  <video autoplay 
   style="filter: contrast(2) hue-rotate(-45deg) saturate(3)"
  ></video>

 --> 


<video autoplay loop></video>
<input type="file" accept="video/MP4" onchange="init(this)">

<script>

const video = document.querySelector("video")

// set the VIDEO gloal so we can easily use it in console
window.VIDEO = video

// this function starts with async,
// which tell the computer that it might be
// waiting around 
// for each function to complete. 
async function init(el){

  /* Load the Video File */
  const media = URL.createObjectURL(el.files[0])
  video.src = media

  // hide the cursor over the video 
  // for presentation
  video.style.cursor = 'none'

  // Now remove the introduction and the input since we don't need them anymore
  el.remove()
  document.querySelector('#introduction').remove()
  
  /* 

    Initialize MIDI devices.

    No, there is no error handling, why do you ask? 

  */

  const midi = await navigator.requestMIDIAccess()

  /*
    The following array magic is pretty new javascript.
   
    The semicolon at the start of the array is because 
    you can write javascript without semicolons until you can't. 
    It's one of those old left-over quirks from long ago.
    I personally find it charming.
  
  */ 

  ;[...midi.inputs.values()].forEach(input => {
    input.onmidimessage = midiMessageRecieved
  })


}
  
/*

  HANDLE MIDI MESSAGE

  Whenever there is a midi signal the following function gets called. 

  The video always starts at the beginning of the movie.
  It then calculates the video location between those two values

*/

const NOTE_ON = 9
const NOTE_OFF = 8
let loop_length = 2000
let low_note = 37
let high_note = 90
let looping = false
async function midiMessageRecieved(message){  
  const VIDEO_DURATION = video.duration
  // So, I'm not going to get into this one here, 
  // it's some gnarly data muxing of the MIDI signal
  // just trust me :-) 
  const cmd = event.data[0] >> 4
  const pitch = event.data[1]
  const velocity = (event.data.length > 2) ? event.data[2] : 1
  const timestamp = Date.now()
  let video_location = 0

  if(cmd === NOTE_OFF || (cmd === NOTE_ON && velocity === 0)) {
    // do something if we get a note off
  } else if (cmd === NOTE_ON) {
    if(pitch < low_note){
      // If the user plays a lower note than low_note
      // the software assumes that should be the beginning of the video
      low_note = pitch
      video_location = 0
    } else if (pitch > high_note){
      // If the user plays a higher note than high_note, 
      // the software assumes that should be the end of the video - 10000ms. 
      high_note = pitch
      video_location = VIDEO_DURATION - 100000
    } else {
      // otherwise, calculate the pitch's location between the two values
      video_location = VIDEO_DURATION * ((pitch - low_note) / 128)
    }

    // set the current location
    video.currentTime = video_location

    // when you do that the video pauses so start playing
    video.play()
  }
   
}


/*

  HANDLE KEYBOARD MESSAGES

*/

// a list of valid keys (just qwerty right now).
// I split the string into an array to generate a lookup table
const key_index = `qwertyuiopasdfghjklzxcvbnm`.split('')

// detect when a user presses a key
document.addEventListener('keydown', function(e){
  
  // this finds where in the array the key is
  const index = key_index.indexOf(e.key)
  // if it's -1, it's not in the array,
  if(index === -1){
    // if user has pressed space, pause
    if(e.key ===  ' ' && !video.paused){video.pause()}
    return
  }
  
  // determine the pitch to play (0.0 being lowest arbitary pitch, 1.0 highest)
  const pitch = index / key_index.length
  // calculate the new location of the video
  let video_location = video.duration *  pitch
  // set the current location
  video.currentTime = video_location
  // because setting the currentTime in the video pauses the video, play the video again
  video.play()
})

/*

  HANDLE SCREEN INTERACTIONS

  takes either a tap for a tablet
  or a mouseclick and move the video

*/

function handleScreenSelect(e){
  /*
    
    e is the event. it gives us the offset from theleft of the screen
    divided by the screen width gives us the location of the event
    by percentage. 

  */
  const x_loc = e.offsetX / window.innerWidth

  // putting something in a try /  catch like this
  // makes sure our software doesn't stop when 
  // something goes wrong. For instance, 
  // if the user clicks anywhere on the screen before
  // the video is initialized, the video will throw
  // an error. Here we catch that error and output
  // a little message to console. 
  try {
    // then we multiply that percentage to the duration of the video
    const video_location = video.duration * x_loc
    // we then use that value to set the current time
    video.currentTime = video_location
    video.play()  
  } catch(e){
    console.log(e)
  }
}

// attach the events. We treat both touch start and mouse down as the same here
document.addEventListener("touchstart", handleScreenSelect)
document.addEventListener("mousedown", handleScreenSelect)

</script>
</body>
</html>
```