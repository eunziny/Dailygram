package com.kitri.daily.board;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;


@RestController
@RequestMapping("/comments")
public class CommController {
	
	   @Autowired
	   private BoardService service;
	   
	   @PostMapping
   	   //@RequestMapping(value="/comments", method=RequestMethod.POST)
	   public List<Comment> addNewComment(@ModelAttribute Comment cmnt) throws Exception {
		  if(cmnt.getCom_seq() == 0) {//새댓글
			  Comment co = new Comment(cmnt.getBoard_seq(),cmnt.getContent(),cmnt.getWriter()); 
			  service.insertNewComment(co);
			  
		  }else {//대댓글
			  Comment co2 = new Comment(cmnt.getBoard_seq(),cmnt.getCom_seq(),cmnt.getContent(),
					  cmnt.getWriter());
			  service.insertRepComment(co2);
		  }
		  List<Comment> coList = service.getComments(cmnt.getBoard_seq());
		  return coList;
		  
	   }
	   
	   @PutMapping
	   public List<Comment> updateComments(@RequestBody Comment cmnt){
		   Comment co = new Comment(cmnt.getCom_seq(),cmnt.getContent());
		   service.updateComment(co);
		   System.out.println("번호 잘 가져옴?"+co.getCom_seq());
		   System.out.println("바뀐 컨텐트인가?:"+co.getContent());
		   System.out.println("여기까지 잘 들어왔냐");
		   List<Comment> coList = service.getComments(cmnt.getBoard_seq());
		   return coList;
	   }
	   
	   @DeleteMapping
	   public List<Comment> deleteComment(@RequestBody Comment cmnt) throws Exception {
		   Comment co = new Comment();
		   co.setCom_seq(cmnt.getCom_seq());
		   co.setPseq(cmnt.getPseq());
		   co.setBoard_seq(cmnt.getBoard_seq());
		   service.deleteComment(co);
		   List<Comment> coList = service.getComments(cmnt.getBoard_seq());
		   return coList;
	   }
	   
	 
}
