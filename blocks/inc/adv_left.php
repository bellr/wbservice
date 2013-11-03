<?
class adv_left extends Template {
    function __construct($action_method,$vars='') {

        $this->$action_method();
    }

    private function block() {
		$banners = array(
		'banner-200x200-europe',
			'banner-200x300-rebate',
			'insta_banner_iframe_200_200',
			'banner-200x200-ForexStart',
			'insta_banner_iframe_200_400',
			'banner-200x300-Rouble');

		$b = rand(0,5);
		$this->tmplName = $banners[$b];
        return $this->vars;
    }
}

?>