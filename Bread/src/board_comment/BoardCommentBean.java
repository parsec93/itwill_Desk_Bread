package board_comment;

import java.sql.Date;

public class BoardCommentBean {
	private int comment_num;
	private int comment_board;
	private String comment_id;
	private Date date;
	private String comment_parent;
	private String comment_content;
	
	
	
	public int getComment_num() {
		return comment_num;
	}
	public void setComment_num(int comment_num) {
		this.comment_num = comment_num;
	}
	public int getComment_board() {
		return comment_board;
	}
	public void setComment_board(int comment_board) {
		this.comment_board = comment_board;
	}
	public String getComment_id() {
		return comment_id;
	}
	public void setComment_id(String comment_id) {
		this.comment_id = comment_id;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public String getComment_parent() {
		return comment_parent;
	}
	public void setComment_parent(String comment_parent) {
		this.comment_parent = comment_parent;
	}
	public String getComment_content() {
		return comment_content;
	}
	public void setComment_content(String comment_content) {
		this.comment_content = comment_content;
	}
	
	
	
}
