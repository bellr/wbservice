<?
session_start();
	require("../customsql.inc.aspx");
	$db = new CustomSQL($DBName);
	$db_pay_desk = new CustomSQL_pay_desk($DBName_pay_desk);
$data = date("Y-m-d");
$mass_day = array("01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31");
$mass_mount = array("(01) Январь","(02) Февраль","(03) Март","(04) Апрель","(05) Май","(06) Июнь","(07) Июль","(08) Август","(09) Сентябрь","(10) Октябрь","(11) Ноябрь","(12) Декабрь",);
$data_mas = explode("-",$data);

///pass = Dst627
$showtable = false;
$error = false;
if (isset($_SESSION['login'])){
	$db_pay_desk = new CustomSQL_pay_desk($DBName_pay_desk);
	$logout = $db->cheak_shop($_SESSION['login'],$_SESSION['pass']);
	$showtable = true;
}
	if(!empty($_POST['enter'])) {
		session_start();
		$pass = md5($_POST['pass']);
			$logout = $db->cheak_shop($_POST['login'],$pass);
				if(!empty($logout)) {
					$_SESSION['login'] = $_POST['login'];
					$_SESSION['pass'] = $pass;
					$showtable = true;
				}
				else {
					$db_pay_desk = new CustomSQL_pay_desk($DBName_pay_desk);
					$error = true;
					$error_mes = "Введенный Вами Логин или пароль неверный";
				}
	}
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>Платежный терминал WM-RB.net</title>
<Meta Http-equiv="Content-Type" Content="text/html; charset=Windows-1251">
<link rel="stylesheet" href="http://merch.wm-rb.net/style.css" type="text/css">
<meta content="none" name="ROBOTS">
</head>
<body bgcolor="#FFFFFF" text="#000000">

<center>
<table border="0" cellspacing="10" cellpadding="0" style="width: 900px; BORDER: #BDB76B 2px solid; background-color: #f3f7ff;">
	<tr>

	<td width="10%" align="center" class="div_include"><center>
	<a href="http://wm-rb.net"><img src="http://wm-rb.net/img/logo.gif" alt="WebMoney в Республике Беларусь" width="190" height="60"></a>
	</center>
	</td>
		<td width="90%" class="div_include" align="right">
<div style="float:left;" align="center"><br />
<span class="black">Наш WMID</span> &nbsp;&nbsp;&nbsp;&nbsp;<a href="http://passport.webmoney.ru/asp/certview.asp?wmid=409306109446" target="_blank" title="Здесь находится аттестат нашего WM идентификатора 409306109446">409306109446</a>
<div style="PADDING-TOP: 5px; PADDING-BOTTOM: 10px;" class="text">Бизнес уровень - <img src="https://stats.wmtransfer.com/Levels/pWMIDLevel.aspx?wmid=409306109446&amp;w=30&amp;h=15&amp;bg=#fcf" alt="Бизнес уровень данного аттестата" width="30" height="15" align="absmiddle"></div>

</div>
<div style="margin-left: 10px; float:right;">
Если у Вас возникли трудности с оплатой или другие вопросы касающиеся<br /> данного терминала, обращайтесь по указанным ниже контактам :<br />
<div style="margin-top:12px;"><b>ICQ:</b> <u>200-368-960</u> <b>|</b> <a href="http://wm-rb.net/support.aspx" target="_blank">Служба поддержки</a> <b>|</b> WMID : <a href="wmk:msgto?to=409306109446&amp;BringToFront=y" title="Отправить сообщение через WebMoney Keeper">409306109446</a></div>

</div>
</td>
	</tr>
	</table>
<? if(!$showtable) {
	if($error) {
echo "
<div style=\"border: #C0C0C0 1px solid; margin:10px 300px; padding: 5px;background-color: #fcfcfc;\">
	<span class=\"red\">{$error_mes}</span>
</div>";
}
echo "<div class=\"inter_form\">
<form method=\"post\" action=\"http://service.wm-rb.net/corp/\">
	<div id=login_t class=\"text\"><b>Login :</b></div>
	<div id=login_f class=\"text\"><input type=\"text\" name=\"login\" style=\"width:110px;\"></div>
	<div id=login_t class=\"text\"><b>Пароль :</b></div>
	<div id=login_f class=\"text\"><input type=\"password\" name=\"pass\" style=\"width:110px;\"></div>
	<div id=padding class=\"text\"><input type=\"submit\" name=\"enter\" value=\"Войти\" style=\"width:110px; margin-top:10px\"></div>
</div>
</form>
";
}
else {
	$info = $db->info_sh($_SESSION['login'],$_SESSION['pass']);
	echo "<div class=\"border\">
<div align=\"left\" class=\"div_include\" style=\"margin:10px\">
	<div class=\"text\">
		<b>&nbsp;СТАТИСТИКА</u></b>
	<hr color=\"#cococo\"  size=\"1\" /><br />
<b>› Ваш кошелек для выплат : </b>{$info[0]['purse']}<br />
<b>› URL для оповещения : </b>{$info[0]['refresh_url']}<br />
	</div>
</div>

<div class=\"div_include\" style=\"background-color: #ffffff; margin:10px\">
<div align=\"left\" style=\"margin-top:10px;\">
<div style=\"float:left;\">Показать статистику с :</div>
<div style=\"margin-left:200px;\">
<form action=\"index.aspx\" method=\"post\" style=\"display: inline;\">
	<select name=\"day_n\">";
	if(!empty($_POST['day_n'])) $day_sel = $_POST['day_n'];
	else $day_sel = $data_mas[2];
	foreach($mass_day as $ar) {
		if($day_sel == $ar)echo "<option value=\"{$ar}\" selected=\"selected\">{$ar}</option>";
		else echo "<option value=\"{$ar}\">{$ar}</option>";
	}
	echo "</select></span>
	<select name=\"mount_n\">";
	$c=1;
	if(!empty($_POST['mount_n'])) $mount_sel = $_POST['mount_n'];
	else $mount_sel = $data_mas[1];
	foreach($mass_mount as $ar) {
		if($mount_sel == $c) echo "<option value=\"{$c}\" selected=\"selected\">{$ar}</option>";
		else echo "<option value=\"{$c}\">{$ar}</option>";
	$c++;
	}
	echo "</select></span>
	<select name=\"year_n\">
	<option value=\"2009\">2009</option>
	<option value=\"2010\" selected=\"selected\">2010</option>
	</select>

</div>
</div>

<div align=\"left\" style=\"margin-top:10px;\">
<div style=\"float:left;\">по:</div>
<div style=\"margin-left:200px;\">
	<select name=\"day_k\">";
	if(!empty($_POST['day_k'])) $day_sel = $_POST['day_k'];
	else $day_sel = $data_mas[2];
	foreach($mass_day as $ar) {
		if($day_sel == $ar)echo "<option value=\"{$ar}\" selected=\"selected\">{$ar}</option>";
		else echo "<option value=\"{$ar}\">{$ar}</option>";

	}
	echo "</select></span>
	<select name=\"mount_k\">";
	$c=1;
	if(!empty($_POST['mount_k'])) $mount_sel = $_POST['mount_k'];
	else $mount_sel = $data_mas[1];
	foreach($mass_mount as $ar) {
		if($mount_sel == $c) echo "<option value=\"{$c}\" selected=\"selected\">{$ar}</option>";
		else echo "<option value=\"{$c}\">{$ar}</option>";
	$c++;
	}
	echo "</select></span>
	<select name=\"year_k\">
	<option value=\"2009\">2009</option>
	<option value=\"2010\" selected=\"selected\">2010</option>
	</select><br /><br />
	<center><input type=\"submit\" name=\"sel_mount\" value=\"Показать\" style=\"width:100px; \"onmouseover=\"this.style.backgroundColor='#E8E8FF';\" onmouseout=\"this.style.backgroundColor='#f3f7ff';\" id=\"cursor\">&nbsp;</center>
</form>
</div>
</div>
<br />";
$data_n = $_POST['year_n']."-".$_POST['mount_n']."-".$_POST['day_n'];
$data_k = $_POST['year_k']."-".$_POST['mount_k']."-".$_POST['day_k'];

$demand = $db_pay_desk->stat_pay_dem($data_n,$data_k,$info[0]['name_shop']);
if(!empty($demand)) {
             echo "<table width=\"100%\" border=\"0\" cellspacing=\"1\" cellpadding=\"4\" bgcolor=\"#F2F2F2\">
			 <tr class=\"text\" bgcolor=\"#CCCCCC\" align=\"center\">
				<td>№ заявки</td>
				<td>E-mail</td>
                <td>Дата</td>
                <td>Статус</td>
              </tr>";
		foreach($demand as $arr) {
	if($arr['4'] == 'n') $tag = "<font color=\"#FF0000\"><b>Не оплачена</b></font>";
	if($arr['4'] == 'yn') $tag = "<font color=\"#0000FF\"><b>Оплачена</b></font>";
	if($arr['4'] == 'y') $tag = "<font color=\"#008000\"><b>Выполнена</b></font>";
	if($arr['4'] == 'er') $tag = "<font color=\"#CC0000\"><b>ОШИБКА</b></font>";
	echo "<tr bgcolor=\"#FFFFFF\" align=center class=text>
<td><a href=\"http://wm-rb.net/user_check_usluga.aspx?d={$arr['0']}\" target=_blank>{$arr['0']}</a></td>
<td align=left>{$arr['1']}</td>
<td>{$arr['2']} {$arr['3']}</td>
<td>{$tag}</td>
</tr>
";
		}
echo "</table>";
}
else echo "<b>По указанной дате платежей нет</b>";



echo "</div>";
}
?>


</div>
</center>
</body>
</html>

