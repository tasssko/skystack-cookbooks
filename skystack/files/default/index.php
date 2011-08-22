<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>Made by Skystack</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body>
<style>
#head{margin:10px auto 20px auto;width:400px;text-align: center}
#landing{margin:0 auto;width:740px;background:#fff;padding:0px 20px 20px 20px;}
#landing h1{font-size:14px;}
#landing .content{margin-top:20px;}
#footer{margin:0 auto;width:600px;padding:15px;}
</style>
	
<div id="head">
		<img src="http://my.skystack.com/img/logo_black_on_trans.png" title="my.skystack.com" />		</div>
    
<div id="landing" class="ui-corner-all" style="">
	<div class="content"><br/>
	<p>This server was crafted by Skystack, with the help of some excellent open source tools. We hope you enjoy this server as much as we enjoyed building it.</p>
	<p>For more on Skystack visit our website <a href="http://www.skystack.com" title="Skystack.com">Skystack.com</a></p>	
	
	<?php
	
	if(isset($_GET['show_php']) && $_GET['show_php'] == 1):
		phpinfo();
	endif;
	
	?>
</div>
	<div style="clear:both;"></div>
</div>

<div id="footer">
	<a href="http://www.skystack.com/">Home</a> • 
	<a href="http://help.skystack.com/help/faqs">Knowledge Base</a> • 
	<a href="http://help.skystack.com/help/faqs">FAQ</a> • 
	<a href="http://www.skystack.com/privacy">Privacy</a> • 
	<a href="http://www.skystack.com/terms-of-service">Terms of Service</a>
	<hr/>Skystack • Version: v0.09b	

	<div class="small">© Copyright 2010 Skystack Limited (#06873486), All Rights Reserved.
	Skystack® and the 'Stack' device are registered trademarks of Skystack Limited. Company registered in England and Wales.</div>

</div>
</body>	
</html>
<!-- skystack_apps/files/default/index.php -->