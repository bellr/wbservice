<?
class title extends Template {

    public  function block() {

        $this->vars = Model::Seo_pattern('HOME')->getInfoModel();

        return $this;
    }
}

?>