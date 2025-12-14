<?php

namespace App\Controller;

use App\Repository\RecipeRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

final class RecipeController extends AbstractController
{

    #[Route('/recette', name: 'recipe.index')]
    public function index(Request $request, RecipeRepository $recipeRepository): Response
    {
        $recipes = $recipeRepository->findAll();
        dd($recipes);
        return $this->render('recipe/index.html.twig', [
            'controller_name' => 'RecipeController',
        ]);
    }

    #[Route('/recette/{slug}-{id}', name: 'recipe.show', requirements: ['id' => '\d+', 'slug' => '[a-z0-9\-]+'])]
    public function show(Request $request, int $id, string $slug): Response
    {
        $slug = $request->attributes->get('slug');
        $id = $request->attributes->getInt('id');

        return $this->render('recipe/show.html.twig', [
            'controller_name' => 'RecipeController',
            'id' => $id,
            'slug' => $slug,
            'person' => [
                'firstName' => 'John',
                'lastName' => 'Doe',
            ],
        ]);
    }
}
