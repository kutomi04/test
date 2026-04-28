<?php

namespace Tests\Feature;

use Tests\TestCase;

class ApiTest extends TestCase
{
    public function test_api_test_endpoint_returns_json_response(): void
    {
        $response = $this->getJson('/api/test');

        $response
            ->assertOk()
            ->assertJson([
                'message' => 'api test',
            ]);
    }
}
