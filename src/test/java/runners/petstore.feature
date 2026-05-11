Feature: Automatizacion API PetStore

  Scenario: Flujo completo PetStore

    * def petId = 10001

    # Crear mascota

    Given url 'https://petstore.swagger.io/v2/pet'
    And request
    """
    {
      "id": #(petId),
      "name": "Firulais",
      "status": "available"
    }
    """
    When method POST
    Then status 200

    # Consultar mascota

    Given url 'https://petstore.swagger.io/v2/pet/' + petId
    When method GET
    Then status 200

    And match response.id == petId
    And match response.name == 'Firulais'

    # Actualizar mascota

    Given url 'https://petstore.swagger.io/v2/pet'
    And request
    """
    {
      "id": #(petId),
      "name": "Firulais Actualizado",
      "status": "sold"
    }
    """
    When method PUT
    Then status 200

    And match response.status == 'sold'

    # Buscar por status

    Given url 'https://petstore.swagger.io/v2/pet/findByStatus?status=sold'
    When method GET
    Then status 200