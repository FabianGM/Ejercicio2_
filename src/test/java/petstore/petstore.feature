Feature: PetStore API testing with Karate
  Background:
    * url baseUrl
    * def petId = 123456
    * def petName = 'fabian-dog'
    * def initialStatus = 'available'
    * def updatedStatus = 'sold'

  Scenario: Add a new pet
    Given path 'pet'
    And request { id: #(petId), name: #(petName), status: #(initialStatus) }
    When method post
    Then status 200
    And match response.id == petId

  Scenario: Get pet by ID
    Given path 'pet', petId
    When method get
    Then status 200
    And match response.name == petName

  Scenario: Update pet name and status
    * def newName = 'fabian-dog-updated'
    Given path 'pet'
    And request { id: #(petId), name: #(newName), status: #(updatedStatus) }
    When method put
    Then status 200
    And match response.status == updatedStatus

  Scenario: Find pets by status
    Given path 'pet', 'findByStatus'
    And param status = updatedStatus
    When method get
    Then status 200
    And match response contains { id: '#(petId)', status: '#(updatedStatus)' }