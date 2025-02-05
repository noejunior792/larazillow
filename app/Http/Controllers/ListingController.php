<?php

namespace App\Http\Controllers;

use App\Models\Listing;
use Illuminate\Http\Request;

class ListingController extends Controller
{
    public function index()
    {
        return inertia(
            'Listing/Index',
            [
                'listings' => Listing::all()
            ]
        );
    }

    public function show(Listing $listing)
    {
        return inertia(

            'Listing/Show',
            [
                'listing' => $listing
            ]

        );
    }

    public function create(){
        return inertia('Listing/Create');
    }
}
