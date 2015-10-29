<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="toggleTesting.aspx.cs" Inherits="trendsensor.toggleTesting" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>Bootstrap Toggle</title>

	<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet" />
	<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet" />
	<link href="bootstrap/css/bootstrap-toggle.css" rel="stylesheet" />
	<link href="bootstrap/css/stylesheet.css" rel="stylesheet" />
	<script src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
</head>
<body>
	<main>
		<div id="usage" class="container">
			<div class="example">
				<input type="checkbox" checked data-toggle="toggle">
			</div>

			<div class="example">
				<div class="checkbox">
					<label>
						<input type="checkbox" data-toggle="toggle">
					</label>
				</div>
				<div class="checkbox">
					<label>
						<input type="checkbox" data-toggle="toggle">
					</label>
				</div>
			</div>

			<div class="example">
				<label class="checkbox-inline">
					<input type="checkbox" checked data-toggle="toggle"> First
				</label>
				<label class="checkbox-inline">
					<input type="checkbox" data-toggle="toggle"> Second
				</label>
				<label class="checkbox-inline">
					<input type="checkbox" data-toggle="toggle"> Third
				</label>
			</div>
		</div>

		<div id="api" class="container">
			<p>Initialize toggles with id <code>toggle-one</code> with a single line of JavaScript.</p>
			<div class="example">
				<input id="toggle-one" checked type="checkbox">
				<script>
				    $(function () {
				        $('#toggle-one').bootstrapToggle();
				    })
				</script>
			</div>

			<p>Options can be passed via data attributes or JavaScript. For data attributes, append the option name to <code>data-</code>, as in <code>data-on="Enabled"</code>.</p>
			<div class="example">
				<input type="checkbox" data-toggle="toggle" data-on="Enabled" data-off="Disabled">
				<input type="checkbox" id="toggle-two">
				<script>
				    $(function () {
				        $('#toggle-two').bootstrapToggle({
				            on: 'Enabled',
				            off: 'Disabled'
				        });
				    })
				</script>
			</div>
			<div class="table-responsive">
				<table class="table table-striped table-condensed">
				<thead>
				<tr>
					<th>Name</th>
					<th>Type</th>
					<th>Default</th>
					<th>Description</th>
				</tr>
				</thead>
				<tbody>
				<tr>
					<td>on</td>
					<td>string | html</td>
					<td><code>"On"</code></td>
					<td>Text of the <em>on</em> toggle</td>
				</tr>
				<tr>
					<td>off</td>
					<td>string | html</td>
					<td><code>"Off"</code></td>
					<td>Text of the <em>off</em> toggle</td>
				</tr>
				<tr>
					<td>size</td>
					<td>string</td>
					<td><code>"normal"</code></td>
					<td>
						Size of the toggle. Possible values are:<code>large</code>,<code>normal</code>,<code>small</code>,<code>mini</code><br>
						Refer to Bootstrap <a href="http://getbootstrap.com/css/#buttons-sizes" target="_blank">Button Sizes</a> documentation for more information.
					</td>
				</tr>
				<tr>
					<td>onstyle</td>
					<td>string</td>
					<td><code>"primary"</code></td>
					<td>
						Style of the <em>on</em> toggle.<br>Possible values are:<code>default</code>,<code>primary</code>,<code>success</code>,<code>info</code>,<code>warning</code>,<code>danger</code><br>
						Refer to Bootstrap <a href="http://getbootstrap.com/css/#buttons-options" target="_blank">Button Options</a> documentation for more information.
					</td>
				</tr>
				<tr>
					<td>offstyle</td>
					<td>string</td>
					<td><code>"default"</code></td>
					<td>
						Style of the <em>off</em> toggle.<br>Possible values are:<code>default</code>,<code>primary</code>,<code>success</code>,<code>info</code>,<code>warning</code>,<code>danger</code><br>
						Refer to Bootstrap <a href="http://getbootstrap.com/css/#buttons-options" target="_blank">Button Options</a> documentation for more information.
					</td>
				</tr>
				<tr>
					<td>style</td>
					<td>string</td>
					<td></td>
					<td>
						Appends the value to the class attribute of the toggle. This can be used to apply custom styles. Refer to Custom Styles for reference.
					</td>
				</tr>
				<tr>
					<td>width</td>
					<td>integer</td>
					<td><em>null</em></td>
					<td>
						Sets the width of the toggle. if set to <em>null</em>, width will be calculated.
					</td>
				</tr>
				<tr>
					<td>height</td>
					<td>integer</td>
					<td><em>null</em></td>
					<td>
						Sets the height of the toggle. if set to <em>null</em>, height will be calculated.
					</td>
				</tr>
				</tbody>
				</table>
			</div>

			<h3>Methods</h3>
			<p>Methods can be used to control toggles directly.</p>
			<div class="example">
				<input id="toggle-demo" type="checkbox" data-toggle="toggle">
			</div>
			<div class="table-responsive">
				<table class="table table-striped table-condensed">
				<thead>
				<tr>
					<th>Method</th>
					<th>Example</th>
					<th>Description</th>
					<th>Demo</th>
				</tr>
				</thead>
				<tbody>
				<tr>
					<td><em>initialize</em></td>
					<td><code>$('#toggle-demo').bootstrapToggle()</code></td>
					<td>Initializes the toggle plugin with options</td>
					<td><button class="btn btn-default btn-xs" onclick="demo.init('#toggle-demo')">Initialize</button></td>
				</tr>
				<tr>
					<td>destroy</td>
					<td><code>$('#toggle-demo').bootstrapToggle('destroy')</code></td>
					<td>Destroys the toggle</td>
					<td><button class="btn btn-default btn-xs" onclick="demo.destroy('#toggle-demo')">Destroy</button></td>
				</tr>
				<tr>
					<td>on</td>
					<td><code>$('#toggle-demo').bootstrapToggle('on')</code></td>
					<td>Sets the toggle to 'On' state</td>
					<td><button class="btn btn-default btn-xs" onclick="demo.on('#toggle-demo')">On</button></td>
				</tr>
				<tr>
					<td>off</td>
					<td><code>$('#toggle-demo').bootstrapToggle('off')</code></td>
					<td>Sets the toggle to 'Off' state</td>
					<td><button class="btn btn-default btn-xs" onclick="demo.off('#toggle-demo')">Off</button></td>
				</tr>
				<tr>
					<td>toggle</td>
					<td><code>$('#toggle-demo').bootstrapToggle('toggle')</code></td>
					<td>Toggles the state of the toggle</td>
					<td><button class="btn btn-default btn-xs" onclick="demo.toggle('#toggle-demo')">Toggle</button></td>
				</tr>
				<tr>
					<td>enable</td>
					<td><code>$('#toggle-demo').bootstrapToggle('enable')</code></td>
					<td>Enables the toggle</td>
					<td><button class="btn btn-default btn-xs" onclick="demo.enable('#toggle-demo')">Enable</button></td>
				</tr>
				<tr>
					<td>disable</td>
					<td><code>$('#toggle-demo').bootstrapToggle('disable')</code></td>
					<td>Disables the toggle</td>
					<td><button class="btn btn-default btn-xs" onclick="demo.disable('#toggle-demo')">Disable</button></td>
				</tr>
				</tbody>
				</table>
			</div>
		</div>


		<div id="events" class="container">
			<h2>Events</h2>
			<hr>

			<h3>Event Propagation</h3>
			<p><span class="label label-primary">Note</span> All events are propagated to and from input element to the toggle. </p>
			<p>You should listen to events from the <code>&lt;input type="checkbox"></code> directly rather than look for custom events.</p>
			<div class="example">
				<input id="toggle-event" type="checkbox" data-toggle="toggle">
				<div id="console-event"></div>
				<script>
				    $(function () {
				        $('#toggle-event').change(function () {
				            $('#console-event').html('Toggle: ' + $(this).prop('checked'))
				        })
				    })
				</script>
			</div>

		</div>

		<div id="demos" class="container">
			
			<h3>Custom Sizes</h3>
			<p>Bootstrap toggle can handle custom sizes by <code>data-width</code> and <code>data-height</code> options.</p>
			<div class="example">
				<input type="checkbox" checked data-toggle="toggle" data-width="100" data-height="75">
				<input type="checkbox" checked data-toggle="toggle" data-height="75">
				<input type="checkbox" checked data-toggle="toggle" data-width="100">
			</div>

			<h3>Colors</h3>
			<p>Bootstrap Toggle supports various colors. Refer to Bootstrap <a href="http://getbootstrap.com/css/#buttons-options" target="_blank">Button Options</a> documentation for more information.</p>
			<div class="example">
				<input type="checkbox" checked data-toggle="toggle" data-onstyle="primary">
				<input type="checkbox" checked data-toggle="toggle" data-onstyle="success">
				<input type="checkbox" checked data-toggle="toggle" data-onstyle="info">
				<input type="checkbox" checked data-toggle="toggle" data-onstyle="warning">
				<input type="checkbox" checked data-toggle="toggle" data-onstyle="danger">
				<input type="checkbox" checked data-toggle="toggle" data-onstyle="default">
			</div>

			<h3>Colors Mix</h3>
			<p>You can style on state as well as the off state.</p>
			<div class="example">
				<input type="checkbox" checked data-toggle="toggle" data-onstyle="success" data-offstyle="danger">
				<input type="checkbox" checked data-toggle="toggle" data-onstyle="warning" data-offstyle="info">
			</div>

			<h3>Custom Style</h3>
			<p>Customized styles can be applied as easily.</p>
			<div class="example">
				<style>
					.toggle.ios, .toggle-on.ios, .toggle-off.ios { border-radius: 20px; }
					.toggle.ios .toggle-handle { border-radius: 20px; }
				</style>
				<input type="checkbox" checked data-toggle="toggle" data-style="ios">
				<style>
					.toggle.android { border-radius: 0px;}
					.toggle.android .toggle-handle { border-radius: 0px; }
				</style>
				<input type="checkbox" checked data-toggle="toggle" data-style="android" data-onstyle="info">
			</div>

			<h3>Custom Text</h3>
			<p>The text can be changed easily with attributes or options.</p>
			<div class="example">
				<input type="checkbox" checked data-toggle="toggle" data-on="Ready" data-off="Not Ready" data-onstyle="success" data-offstyle="danger">
			</div>

			<h3>Icons/Html Text</h3>
			<p>You can easily add icons or images since html is supported for on/off text.</p>
			<div class="example">
				<input type="checkbox" checked data-toggle="toggle" data-on="<i class='fa fa-play'></i> Play" data-off="<i class='fa fa-pause'></i> Pause">
			</div>


			<h3>Animation Speed</h3>
			<p>Transition speed can be easily controlled with css <code>transition</code> property on <code>.toggle-group</code>. You can also turn animation off completely.</p>
			<div class="example">
				<style>
					.slow .toggle-group { transition: left 0.7s; -webkit-transition: left 0.7s; }
					.fast .toggle-group { transition: left 0.1s; -webkit-transition: left 0.1s; }
					.quick .toggle-group { transition: none; -webkit-transition: none; }
				</style>
				<input type="checkbox" checked data-toggle="toggle" data-style="slow">
				<input type="checkbox" checked data-toggle="toggle" data-class="fast">
				<input type="checkbox" checked data-toggle="toggle" data-style="quick">
			</div>
		<div>
	</main>

	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
	<script src="bootstrap/js/bootstrap-toggle.js"></script>
</body>
</html>
