<?php
session_start();
require_once('../../api/Simpla.php');
$simpla = new Simpla();
if (empty($_SERVER['HTTP_REFERER'])) {
	$_SERVER['HTTP_REFERER'] = $simpla->request->post('url', 'string');
}
if (isset($_SESSION['mailer_result'])) {
	unset($_SESSION['mailer_result']);
}
if (empty($_SESSION['mailer_signature'])) {
	$_SESSION['mailer_signature'] = session_id();
}
$result = [
	'valid' => (new DateTime())->add(new DateInterval('PT1M'))->getTimestamp(),
	'tpl' => 'phonerequest',
	'title' => 'Заказ звонка',
	'name' => mb_substr($_POST['name'], 0, 32, 'UTF-8'),
	'phone' => mb_substr($_POST['phone'], 0, 32, 'UTF-8'),
	'sign' => mb_substr($_POST['sign'], 0, 32, 'UTF-8')
];
if (isset($_POST['tpl'])) {	switch (mb_substr($_POST['tpl'], 0, 32, 'UTF-8')) {
	case 'feedback':
		$result['tpl'] = 'feedback';
		$result['title'] = 'Сообщение с сайта';
		$result['text'] = $_POST['text'];
		$simpla->design->assign('text', $result['text']);
		break;
} }
if (intval($simpla->settings->mailer_outdate) < (new DateTime())->getTimestamp()) {
	if (md5($_SERVER['HTTP_REFERER'] . $_SESSION['mailer_signature']) == $result['sign']) {
		if (!preg_match('/^[А-Яа-яЁё\s]+$/u', $result['name'])) {
			$result['code'] = 412;
			$result['message'] = '<span class="text-warning"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>Извините, такой запрос не может быть обработан. Неверный формат имени.</span>';
		} elseif (!preg_match('/^[\d\s\+\-\(\)]+$/u', $result['phone'])) {
			$result['code'] = 412;
			$result['message'] = '<span class="text-warning"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span> Извините, такой запрос не может быть обработан. Неверный формат номера телефона.</span>';
		} else {
			$simpla->design->assign('name', $result['name']);
			$simpla->design->assign('phone', $result['phone']);
			$simpla->notify->email($simpla->settings->comment_email, $result['title'], $simpla->design->fetch($simpla->config->root_dir . 'design/' . $simpla->settings->theme . "/html/email_{$result['tpl']}.tpl"));
			$result['code'] = 202;
			$result['message'] = '<span class="text-success"><span class="glyphicon glyphicon-ok" aria-hidden="true"></span> Спасибо, запрос успешно отправлен.</span>';
			$simpla->settings->mailer_outdate = $result['valid'];
			$_SESSION['mailer_signature'] = uniqid();
		}
	} else {
		$result['code'] = 412;
		$result['message'] = '<span class="text-dander"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span> Извините, такой запрос не может быть обработан.</span>';
	}
} else {
	$result['code'] = 429;
	$result['message'] = '<span class="text-muted"><span class="glyphicon glyphicon-hourglass" aria-hidden="true"></span> Извините, сервис временно не доступен. Повторите попытку через пару минут.</span>';
}
if(isset($_SERVER['HTTP_X_REQUESTED_WITH']) && strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest') {
	unset($_SESSION["{$result['tpl']}_result"]);
	http_response_code($result['code']);
	header('Content-type: application/json; charset=UTF-8');
	header('Cache-Control: must-revalidate');
	header('Pragma: no-cache');
	header('Expires: -1');
	print json_encode($result);
} else {
	$_SESSION["{$result['tpl']}_result"] = $result;
	http_response_code(303);
	header('Location: ' . $_SERVER['HTTP_REFERER']);
	print '';
}