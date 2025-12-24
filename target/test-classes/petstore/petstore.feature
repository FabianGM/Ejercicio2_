Feature: Petstore API - Flujo completo de mascota

  Background:
    * url 'https://petstore.swagger.io/v2'
    * def petId = 987654

  Scenario: Crear, consultar, actualizar y consultar por estatus

    # 1️ Añadir una mascota a la tienda
    Given path 'pet'
    And request
    """
    {
      "id": #(petId),
      "name": "Luna",
      "status": "available"
    }
    """
    When method post
    Then status 200
    And match response.id == petId

    # 2️ Consultar la mascota ingresada previamente (por ID)
    Given path 'pet', petId
    When method get
    Then status 200
    And match response.name == 'Luna'
    And match response.status == 'available'

    # 3️ Actualizar el nombre y el estatus a "sold"
    Given path 'pet'
    And request
    """
    {
      "id": #(petId),
      "name": "Luna Actualizada",
      "status": "sold"
    }
    """
    When method put
    Then status 200
    And match response.status == 'sold'

    # 4️ Consultar la mascota modificada por estatus
    Given path 'pet/findByStatus'
    And param status = 'sold'
    When method get
    Then status 200
    And match response[*].status contains 'sold'
