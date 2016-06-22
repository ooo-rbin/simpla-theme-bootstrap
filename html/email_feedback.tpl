{$subject='Сообщение с сайта' scope=parent}<html>
	<body>
		<p>Сообщение от: {$name|escape}</p>
		<p>Номер телефона: {$phone|escape}</p>
		<hr>
		<pre>{$text|escape}</pre>
	</body>
</html>
