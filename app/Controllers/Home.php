<?php

namespace App\Controllers;

use LandingCore\Core\BaseController;

class Home extends BaseController
{
    public function index()
    {
        $this->seo->setTitle('Landing Working');
        $this->seo->setDescription('Professional SSR landing system.');
        $this->seo->addSchema([
            "@context" => "https://schema.org",
            "@type" => "Organization",
            "name" => "Alonso Dev",
            "url" => current_url()
        ]);

        return $this->render('home');
    }
}