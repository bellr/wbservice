<?php
session_start();
require("customsql.inc.aspx");
	$showtable = true;
	if(!empty($_POST['pay'])) {
		$host = explode('/',$_SERVER['HTTP_REFERER']);
//	cheak_ref($_SERVER['HTTP_REFERER']);
		$showtable = false;
		$errortag = false;
		$db = new CustomSQL($DBName);
		$db_pay_desk = new CustomSQL_pay_desk($DBName_pay_desk);
		$db_admin = new CustomSQL_admin($DBName_admin);
		$db_exchange = new CustomSQL_exchange($DBName_exchange);

		$in_val = trim($_POST['inval']);
		if(!preg_match("/^([0-9])+$/", $_POST['outval'])) $errortag = true;
		if(!preg_match("/^([0-9,\.])+$/", $in_val)) $errortag = true;
		if($_POST['ex_output'] == "EasyPay") if(!preg_match("/^([0-9]){8}$/", $_POST['purse_oplata'])) $errortag = true;
		if($_POST['ex_output'] == "RBK Money") if(!preg_match("/^([a-zA-Z0-9\ \_\-])+@([a-zA-Z0-9\.\-])+(.([a-zA-Z])+)+$/", $_SESSION['email'])) $errortag = true;
		if($_POST['ex_output'] == "YaDengi") if(!preg_match("/^([0-9]){13}$/", $_POST['purse_oplata']) && !preg_match("/^([0-9]){14}$/", $_POST['purse_oplata'])) $errortag = true;
		if(!preg_match("/^([0-9])+$/", $_SESSION['n_order'])) $errortag = true;
		if(!preg_match("/^[a-zA-Z0-9\.\-]+\.[a-zA-Z]+$/", $_SESSION['host_ref'])) $errortag = true;
		if(!preg_match("/^([a-zA-Z0-9\.\ \_\-])+@([a-zA-Z0-9\.\-])+(.([a-zA-Z])+)+$/", $_SESSION['email'])) $errortag = true;
		$info_shop = $db->sel_shop($_SESSION['host_ref']);
		if(empty($info_shop)) {header("Location: include/header.aspx?error=ERROR_REFER"); exit(); }

		if(!$errortag) {
require($home_dir."mailer/smtp-func.aspx");
$from_name=convert_cyr_string("Robot exchange, WM-RB.net",w,k);
	$subject = "����� ������";
	$body = "<div style=\"FONT-SIZE: 12px; FONT-FAMILY: Verdana; COLOR: #676767; LINE-HEIGHT: 18px;\">
������������.<br />

�� ������ ������� ������� ������ �� ������ ����� {$info_shop[0]['name_shop']} �� ������ � {$_SESSION['n_order']}.<br /><br />
-----------------------------------------------------------<br />
� ������ :			{$_POST['did']}<br />
��� ������ :		{$_POST['inval']} {$_POST['ex_output']}<br />
------------------------------------------------------------<br />
����				{$date_pay} {$time_pay}<br /><br />
<br />
������ ������ �� ������ ��������� �� �������� <a href=\"http://wm-rb.net/user_check_usluga.aspx\">��������</a><br />
���� �� ����� ���� ������� ��� ������ �� ��� ��������, �� ������ ���������� ��� ����������� ������ ������� �� <a href=\"http://wm-rb.net/user_check_usluga.aspx?d={$_POST['did']}\">������</a>.<br /><br />
�� ����� ���������� ��� �� ����� �����������, ����������� �� ������ ����,
����� �� ������ ������ ������ �������� WM-RB.net.<br /><br />
���������� ��� �� ������������� ������ �������.<br />
��� ������ ���������� �������, ������ �� �������.<br />
<br />--<br />
� ���������,<br />
������������� WM-RB.net<br />
<br />
<a href='http://wm-rb.net'>������ �������� WebMoney � ���������� ��������</a><br />
Mail: <a href='mailto:$support'>$support</a><br />
ICQ: $icq</div>";

smtpmail($_SESSION['email'],$subject,$body,$from_name);

$db_pay_desk->add_demand($_POST['did'],$_POST['ex_output'],$info_shop[0]['name_shop'],$_POST['purse_oplata'],$in_val,$_POST['outval'],$_SESSION['n_order'],'',$_SESSION['email'],$date_pay,$time_pay);
//���������� ������ �������
	$db_admin->add_id_pay($_POST['did']);
	$id_pay = $db_admin->sel_idpay($_POST['did']);
	$purse = $db_exchange->sel_purse($_POST['ex_output'].'_service');
	$purse_other = $db_exchange->sel_purse($_POST['ex_output']);
$desc_pay = "������ �������� Megashare.by, � ������ {$_SESSION['n_order']}, ID:{$_POST['did']}";
		unset($_SESSION["host_ref"]);
		unset($_SESSION["email"]);
		unset($_SESSION["n_order"]);
		session_destroy();
	}
	else {header("Location: include/header.aspx?error=ERROR_SES"); exit();}
	}
	else {
		$out_val = $_GET['out_val'];
		$n_order = $_GET['n_order'];
		$email = $_GET['email'];

	if($_GET['sig'] == md5("230113050722009:".$_GET['n_order'].":".$_GET['out_val'])) {
		$host = explode('/',$_SERVER['HTTP_REFERER']);
		$host_ref = $host['2'];
		$_SESSION['host_ref'] = $host_ref;
		$_SESSION['email'] = $email;
		$_SESSION['n_order'] = $n_order;
		$db = new CustomSQL($DBName);
		$db_exchange = new CustomSQL_exchange($DBName_exchange);
		$reqID = wm_ReqID();

		$info_shop = $db->sel_shop($host_ref);
		if(empty($info_shop)) {header("Location: include/header.aspx?error=ERROR_SELSHOP");  exit();}
	}
	else {header("Location: include/header.aspx?error=ERROR_H"); exit();}
	}
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>��������� �������� WM-RB.net</title>
<Meta Http-equiv="Content-Type" Content="text/html; charset=Windows-1251">
<link rel="stylesheet" href="style.css" type="text/css">
<meta content="none" name="ROBOTS">
<script src="http://wm-rb.net/include/ajax.js" type="text/javascript" language="JavaScript"></script>
<SCRIPT type="text/javascript">
<!--

function Check_ep() {
if (!document.d1.purse_oplata.value.match('^[0-9]{8}$')) {
alert('EasyPay ���� ������ �� �����');
document.d1.purse_oplata.focus();
return false;
}
return true;
}
function Check_rbk() {
if (!document.d2.purse_oplata.value.match('^([a-zA-Z0-9\ \_\-])+@([a-zA-Z0-9\.\-])+(.([a-zA-Z])+)+$')) {
alert('E-mail RBKmoney ������ �� �����');
document.d2.purse_oplata.focus();
return false;
}
return true;
}
function Check_ya() {
if (!document.d3.purse_oplata.value.match('^[0-9]{13}$') && !document.d3.purse_oplata.value.match('^[0-9]{14}$')) {
alert('Yandex.Money ���� ������ �� �����');
document.d3.purse_oplata.focus();
return false;
}
return true;
}
function show_hide(d){
var id=document.getElementById('d'+d);
if(id) id.style.display=id.style.display=='none'?'block':'none';
document.getElementById('f'+d).style.display = 'none';
 return false;
}
// -->
</SCRIPT>

</head>
<body bgcolor="#FFFFFF" text="#000000">

<center>
<table border="0" cellspacing="10" cellpadding="0" style="width: 900px; BORDER: #BDB76B 2px solid; background-color: #f3f7ff;">
	<tr>
	<td width="10%" align="center" class="div_include"><center>
	<a href="http://service.wm-rb.net"><img src="http://wm-rb.net/img/logo.gif" alt="WebMoney � ���������� ��������" width="190" height="60"></a>
	</center>
	</td>
		<td width="90%" class="div_include" align="right">
<div style="float:left;" align="center"><br />
<span class="black">��� WMID</span> &nbsp;&nbsp;&nbsp;&nbsp;<a href="http://passport.webmoney.ru/asp/certview.asp?wmid=409306109446" target="_blank" title="����� ��������� �������� ������ WM �������������� 409306109446">409306109446</a>
<div style="PADDING-TOP: 5px; PADDING-BOTTOM: 10px;" class="text">������ ������� - <img src="https://stats.wmtransfer.com/Levels/pWMIDLevel.aspx?wmid=409306109446&amp;w=30&amp;h=15&amp;bg=#fcf" alt="������ ������� ������� ���������" width="30" height="15" align="absmiddle"></div>

</div>
<div style="margin-left: 10px; float:right;">
���� � ��� �������� ��������� � ������� ��� ������ ������� ����������<br /> ������� ���������, ����������� �� ��������� ���� ��������� :<br />
<div style="margin-top:12px;"><b>ICQ:</b> <u>562-718-741</u> <b>|</b> <a href="http://wm-rb.net/support.aspx" target="_blank">������ ���������</a> <b>|</b> WMID : <a href="wmk:msgto?to=409306109446&amp;BringToFront=y" title="��������� ��������� ����� WebMoney Keeper">409306109446</a></div>
</div>
</td>
	</tr>
	</table>
<div class="border" align="center">
<?
if($showtable){
echo "<table width=\"100%\" border=\"0\" cellspacing=\"1\" cellpadding=\"10\" align=\"center\" bgColor=\"#ebebeb\">
                      <tr>
                        <td colspan=\"2\" align=\"center\" height=\"60\" background=\"http://wm-rb.net/img/linet_60.gif\">
						<div style=\"FONT-SIZE: 18px; FONT-FAMILY: Trebuchet  MS; color: #000000; FONT-WEIGHT: bold;\">{$info_shop[0]['name_shop']}</div>
						<div style=\"FONT-SIZE: 10px; FONT-FAMILY: verdana, Trebuchet  MS; color: #333333; padding-top:5px\">{$info_shop[0]['desc_shop']}</div></td>
                      </tr>
                      <tr bgColor=\"#f3f7ff\">
                        <td colspan=\"2\" align=\"center\" class=\"text_log\"><b>������  � $reqID</b></td>
                      </tr>
                      <tr bgColor=\"#ffffff\">
                        <td colspan=\"2\" align=\"center\" class=\"text_log\"><b>�������� ������ ������:</b>
						</td>
                      </tr>";
$res = $db_exchange->sel_cur_exch();

	foreach($res as $arr) {
$curens = explode('_',$arr['0']);
$arr['0'] = $curens[0];
echo "<tr bgColor=\"#ffffff\">";
		$n = $arr['0']."_merch";
		$info_direct = $db_exchange->info_direct($n);
				 $res_summ = $out_val / $info_direct[0]["konvers"];
				echo "<td widht=\"95%\" align=\"left\" class=\"text_log\"><div><div style=\"margin-top: 10px; float:left\">{$out_val} <b>BLR</b> = "; printf("%6.2f ",$res_summ); echo "<b>{$arr['2']}</b></div>
				<div style=\"float:right\"><IMG height=\"31\" alt=\"{$arr['0']}\" src=\"http://wm-rb.net/img/{$arr['0']}.gif\" width=\"81\"></div></div></td>";
				echo "<td align=\"center\" widht=\"5%\">";

				if ($arr['0'] == "WMZ" || $arr['0'] == "WMR" || $arr['0'] == "WME" || $arr['0'] == "WMG" || $arr['0'] == "WMU" || $arr['0'] == "WMY" || $arr['0'] == "WMB") { $wmt_purse = $arr['0']; $arr['0'] = "WMT";}
switch ($arr['0']) :

	case ("WMT") :
echo "				<form method=\"post\" action=\"https://service.wm-rb.net/merchant.aspx\">
					<input type=\"hidden\" name=\"ex_output\" value=\"{$wmt_purse}\" readonly=\"readonly\">
					<input type=\"hidden\" name=\"outval\" value=\"{$out_val}\" readonly=\"readonly\">
					<input type=\"hidden\" name=\"inval\" value=\"";printf("%6.2f",$res_summ); echo "\" readonly=\"readonly\">
					<input type=\"hidden\" name=\"did\" value=\"{$reqID}\" readonly=\"readonly\">
					<input type=\"submit\" name=\"pay\" value=\"�������\" style=\"margin-top:5px; width:100px;\"
					onmouseover=\"this.style.backgroundColor='#E8E8FF';\" onmouseout=\"this.style.backgroundColor='#f3f7ff';\"
		    id=\"cursor\"></form>";
	break;
	case ("Z-Payment") :
echo "				<form method=\"post\" action=\"https://service.wm-rb.net/merchant.aspx\">
					<input type=\"hidden\" name=\"ex_output\" value=\"{$arr['0']}\" readonly=\"readonly\">
					<input type=\"hidden\" name=\"outval\" value=\"{$out_val}\" readonly=\"readonly\">
					<input type=\"hidden\" name=\"inval\" value=\"";printf("%6.2f",$res_summ); echo "\" readonly=\"readonly\">
					<input type=\"hidden\" name=\"did\" value=\"{$reqID}\" readonly=\"readonly\">
					<input type=\"submit\" name=\"pay\" value=\"�������\" style=\"margin-top:5px; width:100px;\"
					onmouseover=\"this.style.backgroundColor='#E8E8FF';\" onmouseout=\"this.style.backgroundColor='#f3f7ff';\"
		    id=\"cursor\"></form>";
	break;
case ("EasyPay") :
echo "<div id=\"f1\"><A href=\"\" onclick=\"return show_hide(1);\">�������</A></div>
					<form style=\"display: none;\" id=\"d1\" name=\"d1\" class=\"popupexample\" method=\"post\" action=\"https://service.wm-rb.net/merchant.aspx\" onSubmit=\"return Check_ep()\">
					<code>������� EasyPay ����</code>
					<INPUT id=ep type=\"text\" name=\"purse_oplata\" size=\"9\" maxlength=\"8\"><br />
					<input type=\"hidden\" name=\"ex_output\" value=\"{$arr['0']}\" readonly=\"readonly\">
					<input type=\"hidden\" name=\"outval\" value=\"{$out_val}\" readonly=\"readonly\">
					<input type=\"hidden\" name=\"inval\" value=\"";printf("%6.2f",$res_summ); echo "\" readonly=\"readonly\">
					<input type=\"hidden\" name=\"did\" value=\"{$reqID}\" readonly=\"readonly\">
					<input type=\"submit\" name=\"pay\" value=\"�������\" style=\"margin-top:5px; width:70px;\" onmouseover=\"this.style.backgroundColor='#E8E8FF';\" onmouseout=\"this.style.backgroundColor='#f3f7ff';\"
		    id=\"cursor\"></form>";
	break;
case ("RBK Money") :
echo "<div id=\"f2\"><A href=\"service.wm-rb.net\" onclick=\"return show_hide(2);\">�������</A></div>
					<form style=\"display: none;\" id=\"d2\" name=\"d2\" class=\"popupexample\" method=\"post\" action=\"https://service.wm-rb.net/merchant.aspx\" onSubmit=\"return Check_rbk()\">
					<code>������� RBK Money E-mail</code>
					<INPUT id=rbk type=\"text\" name=\"purse_oplata\" size=\"14\" maxlength=\"42\"><br />
					<input type=\"hidden\" name=\"ex_output\" value=\"{$arr['0']}\" readonly=\"readonly\">
					<input type=\"hidden\" name=\"outval\" value=\"{$out_val}\" readonly=\"readonly\">
					<input type=\"hidden\" name=\"inval\" value=\"";printf("%6.2f",$res_summ); echo "\" readonly=\"readonly\">
					<input type=\"hidden\" name=\"did\" value=\"{$reqID}\" readonly=\"readonly\">
					<input type=\"submit\" name=\"pay\" value=\"�������\" style=\"margin-top:5px; width:100px;\" onmouseover=\"this.style.backgroundColor='#E8E8FF';\" onmouseout=\"this.style.backgroundColor='#f3f7ff';\"
		    id=\"cursor\"></form>";
	break;
case ("YaDengi") :
echo "<div id=\"f3\"><A href=\"service.wm-rb.net\" onclick=\"return show_hide(3);\">�������</A></div>
					<form style=\"display: none;\" id=\"d3\" name=\"d3\" class=\"popupexample\" method=\"post\" action=\"https://service.wm-rb.net/merchant.aspx\" onSubmit=\"return Check_ya()\">
					<code>������� Yandex.Money ����</code>
					<INPUT id=ya type=\"text\" name=\"purse_oplata\" size=\"14\" maxlength=\"14\"><br />
					<input type=\"hidden\" name=\"ex_output\" value=\"{$arr['0']}\" readonly=\"readonly\">
					<input type=\"hidden\" name=\"outval\" value=\"{$out_val}\" readonly=\"readonly\">
					<input type=\"hidden\" name=\"inval\" value=\"";printf("%6.2f",$res_summ); echo "\" readonly=\"readonly\">
					<input type=\"hidden\" name=\"did\" value=\"{$reqID}\" readonly=\"readonly\">
					<input type=\"submit\" name=\"pay\" value=\"�������\" style=\"margin-top:5px; width:100px;\" onmouseover=\"this.style.backgroundColor='#E8E8FF';\" onmouseout=\"this.style.backgroundColor='#f3f7ff';\"
		    id=\"cursor\"></form>";
	break;
	default:
endswitch;
			echo "</td></tr>";
	}
echo "</table>";
}
if(!$showtable) {
//http://atm.wm-rb.net/nncron/exchange_pay.aspx
//https://merchant.webmoney.ru/lmi/payment.asp
echo "
                    <table width=\"100%\" border=\"0\" cellspacing=\"1\" cellpadding=\"10\" align=\"center\" bgColor=\"#ebebeb\">
                      <tr>
                        <td colspan=\"2\" align=\"center\" height=\"60\" background=\"http://wm-rb.net/img/linet_60.gif\">
						<div style=\"FONT-SIZE: 18px; FONT-FAMILY: Trebuchet  MS; color: #000000; FONT-WEIGHT: bold;\">{$info_shop[0]['name_shop']}</div>
						<div style=\"FONT-SIZE: 10px; FONT-FAMILY: verdana, Trebuchet  MS; color: #333333; padding-top:5px\">{$info_shop[0]['desc_shop']}</div></td>
                      </tr>
                      <tr bgColor=\"#ffffff\">
                        <td colspan=\"2\" align=\"center\" class=\"text_log\">";
echo "<div id=\"report\" align=\"left\">
<div class=\"text\" id=padding>
<div class=\"red\">���������� � ������ :</div><br />
					&bull; <u>������������ ������ ������������� � ������� <b>12 �����</b></u><br />
						&bull; ���� ������ �� ����� ��������� � ������� 12 �����, �� �����, ���� ��������, ���������� �����, ����� ���������� ������� �� ��� ���� �� ����������� �������� ��������� �������.</u><br />
						&bull; ����� ������ ������ ��������� ��� �� E-Mail.<br /><br />";
if ($_POST['ex_output'] == "WMZ" || $_POST['ex_output'] == "WMR" || $_POST['ex_output'] == "WME" || $_POST['ex_output'] == "WMG" || $_POST['ex_output'] == "WMU" || $_POST['ex_output'] == "WMY" || $_POST['ex_output'] == "WMB") {
					echo "</div></div><br /><br /><form method=\"post\" action=\"https://merchant.webmoney.ru/lmi/payment.asp\">
					<input type=\"hidden\" name=\"server\" value=\"{$info_shop[0]['server']}\" readonly=\"readonly\">
					<input type=\"hidden\" name=\"output\" value=\"{$_POST['ex_output']}\" readonly=\"readonly\">
					<input type=\"hidden\" name=\"in_val\" value=\"{$_POST['outval']}\" readonly=\"readonly\">
					<input type=\"hidden\" name=\"LMI_PAYEE_PURSE\" value=\"{$purse[0]['purse']}\" readonly=\"readonly\">
					<input type=\"hidden\" name=\"LMI_PAYMENT_AMOUNT\" value=\"{$in_val}\" readonly=\"readonly\">
					<input type=\"hidden\" name=\"LMI_PAYMENT_NO\" value=\"{$id_pay[0]['id_pay']}\" readonly=\"readonly\">
					<input type=\"hidden\" name=\"LMI_PAYMENT_DESC\" value=\"{$desc_pay}\" readonly=\"readonly\">
					<input type=\"submit\" name=\"pay_shop\" value=\"��������\" style=\"width:100px;
		    \"onmouseover=\"this.style.backgroundColor='#E8E8FF';\" onmouseout=\"this.style.backgroundColor='#f3f7ff';\"
		    id=\"cursor\"></form>";
}
elseif ($_POST['ex_output'] == "Z-Payment") {
					echo "</div></div><br /><br /><form method=\"post\" action=\"https://z-payment.ru/merchant.php\">
					<input type=\"hidden\" name=\"server\" value=\"{$info_shop[0]['server']}\" readonly=\"readonly\">
					<input type=\"hidden\" name=\"output\" value=\"{$_POST['ex_output']}\" readonly=\"readonly\">
					<input type=\"hidden\" name=\"in_val\" value=\"{$_POST['outval']}\" readonly=\"readonly\">
					<input type=\"hidden\" name=\"LMI_PAYEE_PURSE\" value=\"3064\" readonly=\"readonly\">
					<input type=\"hidden\" name=\"LMI_PAYMENT_AMOUNT\" value=\"{$in_val}\" readonly=\"readonly\">
					<input type=\"hidden\" name=\"LMI_PAYMENT_NO\" value=\"{$id_pay[0]['id_pay']}\" readonly=\"readonly\">
					<input type=\"hidden\" name=\"LMI_PAYMENT_DESC\" value=\"{$desc_pay}\" readonly=\"readonly\">
					<input type=\"submit\" name=\"pay_shop\" value=\"��������\" style=\"width:100px;
		    \"onmouseover=\"this.style.backgroundColor='#E8E8FF';\" onmouseout=\"this.style.backgroundColor='#f3f7ff';\"
		    id=\"cursor\"></form>";
}
elseif($_POST['ex_output'] == "EasyPay") {
	$hesh = md5($_POST['did'].$_POST['purse_oplata'].$_POST['outval'].$s_k);
	$EP_purse = $db_exchange->EP_purse_input($edit_out_val);
echo "
<div class='red'>��������!!! �������������� �������� ������!</div><br />
<center><b>��������, ����������� ����, �����������.</b></center><br />
&nbsp;&nbsp;&nbsp;&nbsp;����������� <b>{$_POST['outval']} BYR</b> �� ���� <b>EasyPay {$EP_purse[0]['acount']}</b>, � ���������� � ������� <u>�����������</u> ������� <u>������</u> ����� ������ <b>{$_POST['did']}</b>.<br /><br />
						<b>��������!!!</b> ������ ������ ������������� ������ �� ����� <b>{$_POST['purse_oplata']}</b>.<br />
						����� �������� �� ����� �������������.<br /><br />
��� ��������� ������ ����� ������ ��������� �� ��� �������� � ������� ������ \"<b>��������� ������</b>\" ��� �������� ������ � ��������� ������. <br />
	��� ��������� ������ �� ������ � ������� ��������� �� <a href=\"http://service.wm-rb.net/user_check_usluga.aspx?d={$_POST['did']}\" target=\"_blank\">������</a>.<br /><br />
</div></div><br /><br />
<div align=\"center\" class=\"hidden\" id=\"load\"></div>
<center><input id='submit_check' type=\"submit\" name=\"check_ep\" value=\"���������\" onclick=\"checkEasyPay('check_pay_service','{$_POST['did']}','{$hesh}','https://{$_SERVER['HTTP_HOST']}')\" style=\"width:100px;
		    \"onmouseover=\"this.style.backgroundColor='#E8E8FF';\" onmouseout=\"this.style.backgroundColor='#f3f7ff';\"
		    id=\"cursor\"></center>
<br />
</div>";}
elseif($_POST['ex_output'] == "RBK Money") {
echo "<br />
<div class=\"text\" align=\"left\">
	����������� ��������� ����� �� ���� <b>RBK Money {$purse_other[0]['purse']}</b>, � ���������� � ������� <u>�����������</u> ������� ����� ������ <b>{$_POST['did']}</b>, ����� ������ �������� �� ���� <a href=\"http://service.wm-rb.net/user_check_usluga.aspx\" target=\"_blank\">��������</a>.<br />
	��� ��������� ������ �� ������ � ������� ��������� �� <a href=\"http://service.wm-rb.net/user_check_usluga.aspx?d={$_POST['did']}\" target=\"_blank\">������</a>.
</div>";
}
elseif($_POST['ex_output'] == "YaDengi") {
echo "<br />
<div class=\"text\" align=\"left\">
	����������� ��������� ����� �� ���� <b>Yandex.Money {$purse_other[0]['purse']}</b>, � ���������� � ������� <u>�����������</u> ������� ����� ������ <b>{$_POST['did']}</b>, ����� ������ �������� �� ���� <a href=\"http://service.wm-rb.net/user_check_usluga.aspx\" target=\"_blank\">��������</a>.<br />
	��� ��������� ������ �� ������ � ������� ��������� �� <a href=\"http://service.wm-rb.net/user_check_usluga.aspx?d={$_POST['did']}\" target=\"_blank\">������</a>.
</div>";
}echo "</td>
                      </tr>
					  </table>
<div style=\"width: 500px; margin: 20px auto; background-color: #f3f7ff;\">���� � ��� �������� �����-������ ������� �� ������ ������� ���������� ��������� � ������ ��������� ��� �� ����� ������.</div>
";
}
?>

</div>
</center>
</body>
</html>
