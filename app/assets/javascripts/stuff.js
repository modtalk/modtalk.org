document.addEventListener('DOMContentLoaded',function () {
	'use strict'
	var body = document.body;
	var t = (function() {
		var menu_button = document.getElementById('menu_button');
		var slide_cover = document.getElementById('slide_cover');
		menu_button.addEventListener('click', function() {
			body.classList.add("sml-open");
		});
		slide_cover.addEventListener('click', function() {
			body.classList.remove('sml-open');
		});
	});

	// Link Hijacker
	var fast_link_hijack = function() {
		var fast_loader = function(url, push) {
			NProgress.start();
			var req = new XMLHttpRequest();
			req.onload = function () {
				if (this.status != 200) return;
				console.log("Fast Link Request Done");
				var d = document.getElementById('content');
				if (push) history.pushState({ 'path': url, scrollX: window.scrollX, scrollY : window.scrollY}, 'Page 2', url);
				d.innerHTML = this.responseText;
				NProgress.done();
				window.scrollTo(0, 0);
			};
			req.open("get", url + ".partial", true);
			console.log("Fast Link Request: " + url);
			req.send();
		};
		window.onpopstate = function(evt) {
			console.log("History API onpopstate: " + evt.state);
			if (evt.state == undefined)
				fast_loader('index', false);
			else
				fast_loader(evt.state.path, false);
		};
		var links = document.getElementsByClassName('fast-link');
		var length = links.length;
		for (var i = 0; i < length; i++)
		{
			links[i].addEventListener('click', function(evt) {
				evt.preventDefault();
				fast_loader(this.href, true);
				return false;
			});
		}
		console.log("Registered " + length + " fast links");
	};

	if (history.pushState)
	{
		NProgress.configure({showSpinner: false});
		//fast_link_hijack();
	}

	var simulate_mouse_click = function(elem, x, y) {
		var evt = document.createEvent('MouseEvent');
		evt.initMouseEvent('click', true, false, document.defaultView,
			0, x, y, x, y, false, false, false, false, false, elem);
		elem.dispatchEvent(evt);
	};

	var search_handler = function() {
		var root_elem = document.getElementsByTagName('nav')[0];
		var content = document.getElementById('content');
		var pseudo_elem = document.createElement('div');
		var search_button = document.getElementsByClassName('search-icon')[0];
		var textbox = document.getElementById(search_button.getAttribute('related_textbox'));
		body.appendChild(pseudo_elem);
		var force_focus = function(evt) {
			textbox.focus();
		};
		pseudo_elem.addEventListener('click', force_focus, false);
		var touch_listener = function(evt) {
			console.log("Search box lost focus through touch event " + evt);
			root_elem.classList.remove('search_visible');
			textbox.blur();
		};
		search_button.addEventListener('click', function(evt) {
			//content.addEventListener('touchstart', touch_listener, false);
			root_elem.classList.add('search_visible');
			textbox.focus();
			simulate_mouse_click(pseudo_elem, 0, 0);
			textbox.select();
		});
		textbox.addEventListener('blur', function(evt) {
			content.removeEventListener('touchstart', touch_listener, false);
			root_elem.classList.remove('search_visible');
			simulate_mouse_click(pseudo_elem, 0, 0);
		});
	};

	search_handler();
}, false);
