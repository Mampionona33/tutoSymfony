<?php

namespace App\Controller;

use App\Entity\Recipe;
use App\Form\RecipeType;
use App\Repository\RecipeRepository;
use Doctrine\ORM\EntityManagerInterface;
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
        return $this->render('recipe/index.html.twig', [
            'controller_name' => 'RecipeController',
            'recipes' => $recipes,
        ]);
    }
    #[Route('/recette/duree/{duration}', name: 'recipe.duration')]
    public function recipeLowerThan(Request $request, int $duration, RecipeRepository $recipeRepository)
    {
        $recipes = $recipeRepository->findWithDurationLowerThan($duration);
        return new JsonResponse([
            'duration' => $duration,
            'data' => $recipes
        ]);
    }


    #[Route('recette/edit/{id}', name: 'recipe.edit', requirements: ['id' => '\d+'])]
    public function edit(Recipe $recipe, Request $request, EntityManagerInterface $entityManager): Response
    {
        // dd($recipe);
        $form = $this->createForm(RecipeType::class, $recipe);
        $form->handleRequest($request);
        if ($form->isSubmitted() && $form->isValid()) {
            $entityManager->persist($recipe);
            $entityManager->flush();
            $this->addFlash('success', 'Recette modifiée avec succès !');
            return $this->redirectToRoute('recipe.index');
        }

        return $this->render('recipe/edit.html.twig', [
            'controller_name' => 'RecipeController',
            'recipe' => $recipe,
            'form' => $form,
        ]);
    }

    #[Route('/recette/{slug}-{id}', name: 'recipe.show', requirements: ['id' => '\d+', 'slug' => '[a-z0-9\-]+'])]
    public function show(Request $request, int $id, string $slug, RecipeRepository $recipeRepository): Response
    {

        $recipe = $recipeRepository->find($id);
        if ($recipe->getSlug() !== $slug) {
            return $this->redirectToRoute('recipe.show', [
                'id' => $id,
                'slug' => $recipe->getSlug()
            ], 301);
        }

        // dd($recipe);
        return $this->render('recipe/show.html.twig', [
            'controller_name' => 'RecipeController',
            'id' => $id,
            'slug' => $slug,
            'recipe' => $recipe,
        ]);
    }
}
