<?
class title extends Template {
    function __construct($action_method,$vars) {
        $this->$action_method();
    }

    private function block() {

        $this->vars = Model::Seo_pattern()->prop;
        return $this->vars;
    }
}

?>