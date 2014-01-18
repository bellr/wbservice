<?
class head extends Template {

    public function block() {

        $this->vars['dynamic_hesh'] = Config::$staticSetting['HOME']['static_hash'];

        return $this;
    }
}

?>