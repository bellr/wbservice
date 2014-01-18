<?
class main extends Template {

    public function block() {

        $uslugi = Model::Uslugi();

        foreach($uslugi::$category as $key=>$category) {

            $sub_category = dataBase::DBpaydesk()->select('uslugi',
                'name, desc_val, alias_url',
                'where status=1 and name_cat="'.$key.'"',
                'order by id asc');

            if(!empty($sub_category)) {
                foreach($sub_category as $sub) {

                    $sub['name'] = strtolower($sub['name']);
                    $sub['alias_url'] = Config::$base['SERVICE_URL'].'/oplata/'.$sub['alias_url'].'/';
                    $item['item'] .= $this->iterate_tmpl('catalog',__CLASS__,'item',$sub);
                }
            }

            $item['name_category'] = $category;
            $this->vars['sub_category'] .= $this->iterate_tmpl('catalog',__CLASS__,'category',$item);
            $item['item'] = '';
        }

        return $this;
    }
}

?>