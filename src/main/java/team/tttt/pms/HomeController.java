package team.tttt.pms;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	/**
	 * Simply selects the home view to render by returning its name.
	 * @throws HttpServletRequest, IOException
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model, Authentication authentication, HttpServletResponse response) throws ServletException, IOException {




		if(authentication == null ) {
			return "redirect:/user/login";
		}
		User customUser = (User) authentication.getPrincipal();
        List<String> roleNames = new ArrayList<>();
        authentication.getAuthorities().forEach(authority ->{
            roleNames.add(authority.getAuthority());
        });

        String uri = "";


        if(roleNames.contains("S01")) {
        	return "redirect:/stu/main";
        } else if(roleNames.contains("E11")) {
        	return "redirect:/emp/main";
        } else if(roleNames.contains("E12")) {
        	return "redirect:/tch/main";
        } else {
        	return "redirect:/user/login";
        }


	}


}
