package com.example.restservice;

import java.nio.charset.StandardCharsets;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.AfterEach;
import org.springframework.boot.test.context.SpringBootTest;
import org.junit.jupiter.api.BeforeEach;
import org.mockito.Mockito.*;
import static org.junit.jupiter.api.Assertions.assertEquals;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.test.web.servlet.request.MockHttpServletRequestBuilder;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;
import org.springframework.http.MediaType;
import org.mockito.*;
import org.mockito.junit.jupiter.MockitoExtension;
import org.junit.jupiter.api.extension.ExtendWith;


@ExtendWith(MockitoExtension.class)
@SpringBootTest
class progControllerTest {
    //@InjectMocks
    @Mock
    private progController progController;

    @Mock
    private MockMvc mockMvc;
    


    private AutoCloseable closeable;

    @BeforeEach
    void setUp() {
        closeable = MockitoAnnotations.openMocks(progController);
        mockMvc = MockMvcBuilders.standaloneSetup(progController).build();
    }

    @AfterEach
    void closeMocks() throws Exception {
        closeable.close();
    }

    @Test
    void testController() throws Exception {
        int status = 200;
        int param1 = 100;
        double param2 = 2.0;
        String param3 = "test";

        Mockito.when(progController.progController(param1, param2, param3)).thenReturn(new progRecord(status, param1, param2, param3));

        String expected = "{\"statuscode\":200,\"param1\":100,\"param2\":2.0,\"param3\":\"test\"}";
       
        MockHttpServletRequestBuilder request = MockMvcRequestBuilders.get("/prog?param1=100&param2=2.0&param3=test");
            
        String actual = mockMvc.perform(request)
            .andExpect(MockMvcResultMatchers.status().isOk())
            .andExpect(MockMvcResultMatchers.content().contentType(MediaType.APPLICATION_JSON_VALUE))
            .andReturn().getResponse().getContentAsString(StandardCharsets.UTF_8);
        
        Mockito.verify(progController, Mockito.times(1)).progController(param1, param2, param3);
        assertEquals(expected, actual);
    }
}