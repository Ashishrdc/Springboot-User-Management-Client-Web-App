package com.develop.assignmentPart1.controller;

import com.develop.assignmentPart1.dto.LoginDTO;
import com.develop.assignmentPart1.dto.UDTO;
import com.develop.assignmentPart1.dto.UserDTO;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class ViewController {

    private static final String CREATE_USER_URL = "http://localhost:8080/api/auth/create";
    private static final String USER_LOGIN = "http://localhost:8080/api/auth/login";
    private static final String GET_USER_URL = "http://localhost:8080/api/user/{id}";
    private static final String UPDATE_USER_URL = "http://localhost:8080/api/updateUser";
    private static final String GET_USERS_URL = "http://localhost:8080/api/users";
    private static final String DISABLE_USER_URL = "http://localhost:8080/api/users/delete/{id}";
    private static final String ACTIVATE_USER_URL = "http://localhost:8080/api/users/activate/{id}";

    RestTemplate restTemplate = new RestTemplate();

    @GetMapping({"/", "/login"})
    public String loginPage(Model model){
        model.addAttribute("loginDTO", new LoginDTO());
        return "login";
    }

    @PostMapping("/login")
    public String authenticate(@ModelAttribute LoginDTO loginDTO, Model model){
        int statusCode = 0;
        try {
            ResponseEntity<String> response = restTemplate.postForEntity(USER_LOGIN, loginDTO, String.class);
        }
        catch (HttpClientErrorException.NotFound err){
            statusCode = err.getRawStatusCode();
        }

        if(statusCode == 404){
            model.addAttribute("errClasses", "text-center alert-danger emsg err" );
            model.addAttribute("errMsg", "Bad Credentials");
            return "login";
        }
        return "redirect:/userlist";
    }


    @GetMapping("/register")
    public String registerPage(Model model){
        model.addAttribute("UDTO", new UDTO());
        return "register";
    }

    // Uploading File And Register
    @PostMapping("/register")
    public String postRegister(@ModelAttribute UDTO userDTO,
                            @RequestParam(value = "image", required = false) MultipartFile file,
                            Model model) throws IOException {
        Resource fileResource = file.getResource();
        ObjectMapper objectMapper = new ObjectMapper();
        String user = objectMapper.writeValueAsString(userDTO);

        /////////////////////////////////
        HttpHeaders fileHeaders = new HttpHeaders();
        fileHeaders.set("Content-Type", "multipart/form-data");
        fileHeaders.set("Accept", "application/json");

        MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
        map.add("user", user);
        map.add("file", fileResource);
        HttpEntity<MultiValueMap<String,Object>> entity = new HttpEntity<>(map, fileHeaders);
        /////////////////////////////////


        String message = "";
        try {
            ResponseEntity<String> response = restTemplate.exchange(CREATE_USER_URL, HttpMethod.POST, entity, String.class);
        } catch (HttpClientErrorException.BadRequest err) {
            message = err.getResponseBodyAsString();
        }

        if (message.equals("Username already exists!")){
            model.addAttribute("errUsername", message);
            model.addAttribute("fieldUsername", "err");
            return "register";
        }
        if (message.equals("Email already exists!")) {
            model.addAttribute("errEmail", message);
            model.addAttribute("fieldEmail", "err");
            return "register";
        }

        model.addAttribute("classes", "text-center alert-success successmsg");
        model.addAttribute("saved", "User Added Successfully");
        return "register";
    }

    //====================================================//
    @GetMapping("/userlist")
    public String userList(Model model){
//        HttpHeaders headers = new HttpHeaders();
//        headers.setAccept(Arrays.asList(MediaType.APPLICATION_JSON));
//        HttpEntity<String> entity = new HttpEntity<>(headers);
        ResponseEntity<List<UserDTO>> responseEntity = restTemplate.exchange(GET_USERS_URL, HttpMethod.GET, null, new ParameterizedTypeReference<List<UserDTO>>() {
        });
        List<UserDTO> userlist = responseEntity.getBody();
        model.addAttribute("users", userlist);
        return "userlist";
    }

    @GetMapping("userlist/edituser/{id}")
    public String editUser(@PathVariable int id, Model model){
        Map<String, Integer> params = new HashMap<>();
        params.put("id", id);

        ResponseEntity<UserDTO> userDTO =
                restTemplate.exchange(GET_USER_URL,
                        HttpMethod.GET,
                        null,
                        UserDTO.class, params);
        UserDTO response = userDTO.getBody();
        UserDTO edituser = new UserDTO();

        // AutoFilling the form
        edituser.setId(response.getId());
        edituser.setEmail(response.getEmail());
        edituser.setUsername(response.getUsername());
        edituser.setPhoto(response.getPhoto());
        model.addAttribute("edituser", edituser);

        return "edituser";
    }

    @PostMapping("/userlist/edituser/{id}")
    public String updateUser(@ModelAttribute UDTO userDTO, @RequestPart(value = "image", required = false) MultipartFile file,
                             Model model) throws IOException{

        Resource fileResource = file.getResource();

        ObjectMapper objectMapper = new ObjectMapper();
        String user = objectMapper.writeValueAsString(userDTO);

        /////////////////////////////////
        HttpHeaders fileHeaders = new HttpHeaders();
        fileHeaders.set("Content-Type", "multipart/form-data");
        fileHeaders.set("Accept", "application/json");

        MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
        map.add("user", user);
        map.add("file", fileResource);
        HttpEntity<MultiValueMap<String,Object>> entity = new HttpEntity<>(map, fileHeaders);

        ResponseEntity<String> response = restTemplate.exchange(UPDATE_USER_URL, HttpMethod.POST, entity, String.class);
        model.addAttribute("classes", "text-center alert-success successmsg");
        model.addAttribute("saved", "Profile Saved");
        return editUser(userDTO.getId(), model);
    }

    @GetMapping("/userlist/delete/{id}")
    public String disableUser(@PathVariable int id, Model model){
        Map<String, Integer> params = new HashMap<>();
        params.put("id", id);
        ResponseEntity<String> result = restTemplate.exchange(DISABLE_USER_URL, HttpMethod.GET, null, String.class, params);
        model.addAttribute("msg", result.getBody());
        return "redirect:/userlist";
    }

    @GetMapping("/userlist/activate/{id}")
    public String activateUser(@PathVariable int id, Model model){
        Map<String, Integer> params = new HashMap<>();
        params.put("id", id);
        ResponseEntity<String> result = restTemplate.exchange(ACTIVATE_USER_URL, HttpMethod.GET, null, String.class, params);

        model.addAttribute("msg", result.getBody());
        return "redirect:/userlist";
    }
}
