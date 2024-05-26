-- Delimiter is set to // to define the entire stored procedure block
DELIMITER //

-- 1. Stored procedure to get customers who rented 'Action' movies
CREATE PROCEDURE GetActionCustomers()
BEGIN
    SELECT first_name, last_name, email
    FROM customer
    JOIN rental ON customer.customer_id = rental.customer_id
    JOIN inventory ON rental.inventory_id = inventory.inventory_id
    JOIN film ON film.film_id = inventory.film_id
    JOIN film_category ON film_category.film_id = film.film_id
    JOIN category ON category.category_id = film_category.category_id
    WHERE category.name = "Action"
    GROUP BY first_name, last_name, email;
END //

-- 2. Dynamic stored procedure to get customers by category
CREATE PROCEDURE GetCustomersByCategory(IN genre VARCHAR(255))
BEGIN
    SELECT first_name, last_name, email
    FROM customer
    JOIN rental ON customer.customer_id = rental.customer_id
    JOIN inventory ON rental.inventory_id = inventory.inventory_id
    JOIN film ON film.film_id = inventory.film_id
    JOIN film_category ON film_category.film_id = film.film_id
    JOIN category ON category.category_id = film_category.category_id
    WHERE category.name = genre
    GROUP BY first_name, last_name, email;
END //

-- 3. Stored procedure to get categories with a minimum number of films
CREATE PROCEDURE GetCategoriesWithMinFilms(IN min_films INT)
BEGIN
    SELECT category.name, COUNT(film.film_id) AS number_of_films
    FROM category
    JOIN film_category ON category.category_id = film_category.category_id
    JOIN film ON film.film_id = film_category.film_id
    GROUP BY category.name
    HAVING number_of_films > min_films;
END //

-- Reset the delimiter back to the default semicolon
DELIMITER ;