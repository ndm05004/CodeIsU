<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<div id="gantt_here" style='width:100%; height:600px;'></div>
	<link
  rel="stylesheet"
  href="http://cdn.dhtmlx.com/gantt/edge/dhtmlxgantt.css"
  type="text/css"
/>
<script src="http://cdn.dhtmlx.com/gantt/edge/dhtmlxgantt.js"></script>

	<script>

	  // 웹소켓 연결
// 	  connect();

		gantt.init("gantt_here");

		gantt.parse({
			data: [
				{ id: 1, text: "Project #2", start_date: "01-04-2023", duration: 18, progress: 0.4, open: true },
				{ id: 2, text: "Task #1", start_date: "02-04-2023", duration: 8, progress: 0.6, parent: 1 },
				{ id: 3, text: "Task #2", start_date: "11-04-2023", duration: 8, progress: 0.6, parent: 1 }
			],
			links: [
				{id: 1, source: 1, target: 2, type: "1"},
				{id: 2, source: 2, target: 3, type: "0"}
			]
		});
	</script>

<script>
	(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
	(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
	m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
	})(window,document,'script','//www.google-analytics.com/analytics.js','ga');

	ga('create', 'UA-11031269-1', 'auto');
	ga('send', 'pageview');
</script>
<script src="https://cdn.ravenjs.com/3.10.0/raven.min.js"></script>
<script>Raven.config('https://25a6d5e8c35148d195a1967d8374ffca@sentry.dhtmlx.ru/6').install()</script>