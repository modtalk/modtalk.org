(function() {
	function debounce(func, wait, immediate) {
		var timeout;
		return function() {
			var context = this, args = arguments;
			clearTimeout(timeout);
			timeout = setTimeout(function() {
				timeout = null;
				if (!immediate) func.apply(context, args);
			}, wait);
			if (immediate && !timeout) func.apply(context, args);
		};
	};
	var loader = (function () {
		'use strict'
		var body = document.body;
		var title_elem = document.getElementsByTagName('title')[0];
		var box_root = document.getElementById('search-box-root');
		var search = document.getElementById('search');
		var template = document.getElementById('result').innerHTML;
		var finish_load = function() {
			Mustache.parse(template);
		};
		var handle_results = function(result_pane, obj) {
			while (result_pane.firstChild) {
				result_pane.removeChild(result_pane.firstChild);
			}
			for (var i = 0; i < obj.length; i++) {
				var result_elem = document.createElement('div');
				result_elem.innerHTML = Mustache.render(template, obj[i]);
				result_pane.appendChild(result_elem);
			};
		};
		var get_url = function(query) {
			return query === "" ? '/search' : '/search?query=' + encodeURIComponent(query);
		};
		var get_req_url = function(query) {
			return query === "" ? '/search' : '/search.json?query=' + encodeURIComponent(query);
		};
		var get_title = function(query) {
			return query === "" ? 'Modtalk Search' : 'Modtalk Search: ' + query;
		};
		var mutate_history = function(query) {
			var url = get_url(query);
			var title = get_title(query);
			var new_state = { query : query, type : 'search' };
			if (history.state.type === 'search') {
				history.replaceState(new_state, title, url);
			} else {
				history.pushState(new_state, title, url);
			}
		};
		var stop_typing = function(results) {
			return function(evt) {
				var query = this.value;
				mutate_history(query);
				if (query === "" || (evt.keyCode < 32 && evt.keyCode != 8)) {
					results.innerHTML = '';
				} else {
					var req = new XMLHttpRequest()
					req.onload = function() {
						if (this.status != 200)
							return;
						handle_results(results, JSON.parse(this.responseText));
					};
					req.open('get', get_req_url(query), true);
					req.send();
				}
			};
		};
		var register_events = function(elem) {
			var target_id = elem.getAttribute('data-results-pane');
			if (target_id == null)
				return;
			var results = document.getElementById(target_id);
			elem.addEventListener('keypress', debounce(stop_typing(results), 150));
		};
		var search_autocomplete = function() {
			var searchboxes = document.getElementsByClassName('search-box');
			for (var i = searchboxes.length - 1; i >= 0; i--) {
				register_events(searchboxes[i]);
			};
			var button = document.getElementsByClassName('search-button');
			for (var i = 0; i < button.length; i++) {
				button[i].addEventListener('click', function(evt) {
					evt.preventDefault();
					box_root.classList.toggle('hidden-xs');

					search.focus();
					return false;
				})
			};
		};
		search_autocomplete();
		return {
			finish: finish_load
		}
	});
	document.onreadystatechange = function () {
		if (document.readyState == "interactive") {
			loader = loader();
		} else if (document.readyState === "complete") {
			loader().finish();
		}
	};
	document.addEventListener('page:change', loader);
})();