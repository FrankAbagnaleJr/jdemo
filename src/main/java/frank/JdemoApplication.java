package frank;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class JdemoApplication {

    public static void main(String[] args) {
        SpringApplication.run(JdemoApplication.class, args);
        System.out.println("启动成功");
    }

}
