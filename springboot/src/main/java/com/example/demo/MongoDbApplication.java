package com.example.demo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMethod;
import com.example.demo.User;

@CrossOrigin(origins = "http://localhost:57833", methods = { RequestMethod.GET, RequestMethod.POST })
@SpringBootApplication
@RestController
public class MongoDbApplication {
	private final MongoTemplate mongoTemplate;

	@Autowired
	public MongoDbApplication(MongoTemplate mongoTemplate) {
		this.mongoTemplate = mongoTemplate;
	}

	public static void main(String[] args) {
		SpringApplication.run(MongoDbApplication.class, args);
	}

	@GetMapping("/hello")
	public String hello(@RequestParam(value = "name", defaultValue = "World") String name) {
		return String.format("Hello %s!", name);
	}

	@GetMapping("/user")
	public List<User> getAllUsers() {
		return mongoTemplate.findAll(User.class);
	}

	@PostMapping("/user")
	public void createUser(@RequestBody User user) {
		mongoTemplate.save(user);
	}
}
