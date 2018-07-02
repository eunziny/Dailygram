package com.kitri.daily.board;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/comments")
public class CommController {
	
	   @Autowired
	   private BoardService service;

	   
	   @PostMapping
   	   //@RequestMapping(value="/comments", method=RequestMethod.POST)
	   public void addNewComment(@ModelAttribute Comment cmnt) {
		  if(cmnt.getCom_seq() == 0) {//»õ´ñ±Û
			  Comment co = new Comment(cmnt.getBoard_seq(),cmnt.getContent(),cmnt.getWriter()); 
			  service.insertNewComment(co);
		  }else {//´ë´ñ±Û
			  Comment co2 = new Comment(cmnt.getBoard_seq(),cmnt.getCom_seq(),cmnt.getContent(),
					  cmnt.getWriter());
			  service.insertRepComment(co2);
		  }
		  
		  
	   }
	   
	   @GetMapping
	   public List<Comment> getComments(@RequestParam int board_seq){
		   List<Comment> coList = service.getComments(board_seq);
		   return coList;
	   }
}
