$(document).ready(function() {

	$("audio").on("play", function() {
	  var _this = $(this);
	  var pauseButton = $('.pauseButton');
	  $("audio").each(function(i,el) {
	    if(!$(el).is(_this))
	    $(el).get(0).pause();
	  });
	});

});

var tracks = document.getElementsByTagName('audio');
var trackArray = Array.prototype.slice.call(tracks);

var startNext = function(position) {
	//check in here if this is last track
	//if it is, loop back to start
	trackArray[position + 1].play();
};

var spinner = function() {
	$('.sk-spinner-wandering-cubes').show();
	$('.artist').css("opacity", ".5");
};

function isPlaying() {
	for (i = 0; i < trackArray.length; i++) {
		if (trackArray[i].paused) {
			stylePaused(trackArray[i]);
		};
	};
};

function loadTracks() {
	for (i = 0; i < tracks.length; i++) {
		tracks[0].load();
		tracks[0].onloadeddata = function() {
			alert("loaded track");
		};
	};
};

function whenPlaying(position) {
	var track = trackArray[position];
	var play = track.className;
	var pause = 'Paused' + play;
	var element = document.getElementById(play);
	var otherElement = document.getElementById(pause);
	track.onplaying = function() {
		element.style.display = 'none';
		otherElement.style.display = 'inline-block';
		isPlaying();
	};
};

function playTune(position) { 
	var track = tracks[position];
	track.play();
	whenPlaying(position);
};

function hitPause(position) {
	var track = trackArray[position];
	track.pause();
	stylePaused(track);
};

function stylePaused(track) {
	var play = track.className;
	var pause = 'Paused' + play;
	var element = document.getElementById(play);
	var otherElement = document.getElementById(pause);
	if (track.paused) {
		otherElement.style.display = 'none';
		element.style.display = 'inline-block';
	}
};
