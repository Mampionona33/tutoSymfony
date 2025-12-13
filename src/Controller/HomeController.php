<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

final class HomeController extends AbstractController
{
    #[Route('/', name: 'app_home')]
    function index(Request $request): Response
    {
        $name = $request->query->get('name', 'World'); // Default to 'World' if 'name' parameter is not provided
        return new Response("Hello $name");
    }
}
