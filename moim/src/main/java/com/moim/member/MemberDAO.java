package com.moim.member;
import com.moim.stat.*;
import com.moim.noimg.*;
import java.sql.*;
import java.util.*;

import com.moim.review.ReviewDTO;

public class MemberDAO {
	
	Connection conn;
	PreparedStatement ps;
	ResultSet rs;
	
	public MemberDAO() {
		
	}
	/**회원가입 메서드*/
	public int joinMem(MemberDTO dto) {
		try {
			conn=com.moim.db.MoimDB.getConn();
			String sql="insert into moim_member values(moim_member_idx.nextval,?,?,?,?,?,?,?,sysdate,0)";
			ps=conn.prepareStatement(sql);
			ps.setString(1, dto.getName());
			ps.setString(2, dto.getId());
			ps.setString(3, dto.getPwd());
			ps.setString(4, dto.getEmail());
			ps.setString(5, dto.getLocal());
			ps.setInt(6,dto.getAge());
			ps.setString(7, dto.getHobby());
			int count=ps.executeUpdate();
			return count;
		}catch(Exception e) {
			e.printStackTrace();
			return -1;
		}finally {
			try {
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			}catch(Exception e2) {
				
			}
		}
	}
	
	/**아이디 중복 체크 메서드*/
	public boolean checkId(String id) {
		try {
			conn=com.moim.db.MoimDB.getConn();
			String sql="select name from moim_member where id=?";
			ps=conn.prepareStatement(sql);
			ps.setString(1,id);
			rs=ps.executeQuery();
			return rs.next();
		}catch(Exception e){
			e.printStackTrace();
			return false;
		}finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			}catch(Exception e2){
				
			}
		}
		
	}
	
	/**로그인 관련 메서드*/
	public MemberDTO login(String id, String pwd) {
		try {
			conn=com.moim.db.MoimDB.getConn();
			String sql="select * from moim_member where id=? and pwd=?";
			ps=conn.prepareStatement(sql);
			ps.setString(1, id);
			ps.setString(2, pwd);
			rs=ps.executeQuery();
			MemberDTO dto=null;
			if(rs.next()) {
				int idx=rs.getInt("idx");
				String name=rs.getString("name");
				String email=rs.getString("email");
				String local=rs.getString("local");
				int age=rs.getInt("age");
				String hobby=rs.getString("hobby");
				java.sql.Date joindate=rs.getDate("joindate");
				int manager=rs.getInt("manager");
				
				dto=new MemberDTO(idx,name,id,pwd,email,local,age,hobby,joindate,manager);
			}
			return dto;
		}catch(Exception e) {
			e.printStackTrace();
			return null;
		}finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			}catch(Exception e2) {
				
			}
		}
	}
	
	/**멤버 조회 메서드*/
	public MemberDTO getMem(int idx) {
		try {
			conn=com.moim.db.MoimDB.getConn();
			String sql="select * from moim_member where idx=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, idx);
			rs=ps.executeQuery();
			MemberDTO dto=null;
			if(rs.next()) {
				String name=rs.getString("name");
				String id=rs.getString("id");
				String pwd=rs.getString("pwd");
				String email=rs.getString("email");
				String local=rs.getString("local");
				int age=rs.getInt("age");
				String hobby=rs.getString("hobby");
				java.sql.Date joindate=rs.getDate("joindate");
				int manager=rs.getInt("manager");
				dto=new MemberDTO(idx, name, id, pwd, email, local, age, hobby, joindate, manager);
			}
			return dto;
		}catch(Exception e) {
			e.printStackTrace();
			return null;
		}finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			}catch(Exception e2) {}
		}
	}
	/**수정 메서드*/
	public int updateMem(MemberDTO dto) {
		try {
			conn=com.moim.db.MoimDB.getConn();
			String sql="update moim_member set name=?,id=?,pwd=?,email=?,local=?,age=?,hobby=? where idx=?";
			ps=conn.prepareStatement(sql);
			ps.setString(1, dto.getName());
			ps.setString(2, dto.getId());
			ps.setString(3, dto.getPwd());
			ps.setString(4, dto.getEmail());
			ps.setString(5, dto.getLocal());
			ps.setInt(6, dto.getAge());
			ps.setString(7, dto.getHobby());
			ps.setInt(8, dto.getIdx());
			int count=ps.executeUpdate();
			return count;
		}catch(Exception e) {
			e.printStackTrace();
			return -2;
		}finally {
			try {
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			}catch(Exception e2) {}
		}
	}
	/**댓글 조회 메서드*/
	public ArrayList<NoimgDTO> getMyQna(int category,int idx_member,int ls,int cp){
		try {
			conn=com.moim.db.MoimDB.getConn();
			int start=(cp-1)*ls+1;
			int end=(cp*ls);
			String sql="select * from "
					+ "(select rownum as rnum,a.* from "
					+ "(select * from moim_noimg where category=? and idx_member=? order by ref desc,sunbun asc)a)b "
					+ "where rnum>=? and rnum<=?" ;
			ps=conn.prepareStatement(sql);
			ps.setInt(1, category);
			ps.setInt(2, idx_member);
			ps.setInt(3, start);
			ps.setInt(4, end);
			rs=ps.executeQuery();
			ArrayList<NoimgDTO> arr=new ArrayList<NoimgDTO>();
			while(rs.next()) {
				int idx_info=rs.getInt("idx_info");
				int idx=rs.getInt("idx");
				String writer=rs.getString("writer");
				String subject=rs.getString("subject");
				String content=rs.getString("content");
				java.sql.Date writedate=rs.getDate("writedate");
				int ref=rs.getInt("ref");
				int lev=rs.getInt("lev");
				int sunbun=rs.getInt("sunbun");
				
				NoimgDTO dto=new NoimgDTO(idx, idx_member, idx_info, category, writer, subject, content, writedate, ref, lev, sunbun);
				arr.add(dto);
			}
			return arr;
		}catch(Exception e) {
			e.printStackTrace();
			return null;
		}finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			}catch(Exception e2) {}
		}
	}
	/**후기 조회 메서드*/
	public ArrayList<ReviewDTO> getMyReview(int idx_member,int ls,int cp){
		try {
			conn=com.moim.db.MoimDB.getConn();
			int start=(cp-1)*ls+1;
			int end=(cp*ls);
//			String sql="select * from moim_review where idx_member=?";
			String sql="select * from(select rownum as rnum,a.*from(select * from moim_review where idx_member=? order by idx_member)a)b where rnum>=? and rnum<=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, idx_member);
			ps.setInt(2, start);
			ps.setInt(3, end);
			ArrayList<ReviewDTO> arr=new ArrayList<ReviewDTO>();
//			ps.setInt(1, idx_member);
			rs=ps.executeQuery();
			while(rs.next()) {
				int idx=rs.getInt("idx");
				String moimname=rs.getString("moimname");
				String writer=rs.getString("writer");
				String local=rs.getString("local");
				String hobby=rs.getString("hobby");
				String subject=rs.getString("subject");
				String content=rs.getString("content");
				String img=rs.getString("img");
				java.sql.Date writedate=rs.getDate("writedate");
				
				
				ReviewDTO dto=new ReviewDTO(idx, idx_member, moimname, writer, local, hobby, subject, content, img, writedate);
				arr.add(dto);
			}
			return arr;
		}catch(Exception e) {
			e.printStackTrace();
			return null;
		}finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			}catch(Exception e2) {}
		}
	}
	/**모임 카테고리 가져오기 메서드*/
	public HashMap<Integer,String> moimCategory(){
		try {
			conn=com.moim.db.MoimDB.getConn();
			String sql="select idx,hobby from moim_info";
			ps=conn.prepareStatement(sql);
			HashMap<Integer,String> map=new HashMap<>();
			rs=ps.executeQuery();
			
			while(rs.next()) {
				int idx=rs.getInt(1);
				String hobby=rs.getString(2);
				map.put(idx, hobby);
			}
			return map;
		}catch(Exception e) {
			e.printStackTrace();
			return null;
		}finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			}catch(Exception e2) {}
		}
	}
	
	/**모임 인원 가져오기 메서드*/
	public HashMap<Integer,String> getNowMem(){
		try {
			conn=com.moim.db.MoimDB.getConn();
			String sql="select idx,nowmem,maxmem from moim_info";
			ps=conn.prepareStatement(sql);
			HashMap<Integer,String> hm=new HashMap<Integer,String>();
			rs=ps.executeQuery();
			while(rs.next()) {
				int idx=rs.getInt("idx");
				String nowmem=Integer.toString(rs.getInt("nowmem"));
				String maxmem=Integer.toString(rs.getInt("maxmem"));
				String mem=nowmem+"/"+maxmem;
				hm.put(idx, mem);
			}
			return hm;
		}catch(Exception e) {
			e.printStackTrace();
			return null;
		}finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			}catch(Exception e2) {}
		}
	}
	/**모임이름 가져오기 메서드*/
	public HashMap<Integer, String> moimName(){
		try {
			conn=com.moim.db.MoimDB.getConn();
			String sql="select idx,moimname from moim_info";
			ps=conn.prepareStatement(sql);
			HashMap<Integer, String> map=new HashMap<>();
			rs=ps.executeQuery();
			
			while(rs.next()) {
				int idx=rs.getInt(1);
				String moimname=rs.getString(2);
				map.put(idx, moimname);
			}
			return map;
			
		}catch(Exception e) {
			e.printStackTrace();
			return null;
		}finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			}catch(Exception e2) {}
		}
	}
	
	/**참여중인 모임 조회 메서드*/
	public ArrayList<StatDTO> getMyStat(int idx_member,int ls,int cp,int stat){
		try {
			conn=com.moim.db.MoimDB.getConn();
			int start=(cp-1)*ls+1;
			int end=(cp*ls);
			String sql="select * from(select rownum as rnum,a.*from(select * from moim_stat where idx_member=? and ";
			if(stat==1) {
				sql=sql+"stat in(1,0))a)b where rnum>=? and rnum<=?";
			}else{
				sql=sql+"stat=0)a)b where rnum>=? and rnum<=?";				
			}
			ps=conn.prepareStatement(sql);
			ps.setInt(1, idx_member);
			ps.setInt(2, start);
			ps.setInt(3, end);
			ArrayList<StatDTO> arr=new ArrayList<StatDTO>();
			rs=ps.executeQuery();
			while(rs.next()) {
				int idx=rs.getInt("idx");
				int idx_info=rs.getInt("idx_info");
				java.sql.Date joindate=rs.getDate("joindate");
				String content=rs.getString("content");
				StatDTO dto=new StatDTO(idx, idx_member, idx_info, stat, joindate, content);
				arr.add(dto);
			}
			return arr;
		}catch(Exception e) {
			e.printStackTrace();
			return null;
		}finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			}catch(Exception e2) {}
		}
	}
	
	/**총 작성 수 관련 메서드*/
	/**cul 
	 * 1.내가 쓴 후기 총 수
	 * 2.내가 쓴 댓글QnA 총 수
	 * 3.참여중인 모임 총 수
	 * 4.내가 만든 모임 총 수*/
	public int getTotal(String table,int idx_member,int cul) {
		try {
			conn=com.moim.db.MoimDB.getConn();
			String sql="select count(*) from "+table+" where idx_member=? ";
			if(table.equals("moim_review")&&cul==1) {
				ps=conn.prepareStatement(sql);
			}else if(table.equals("moim_noimg")&&cul==2) {
				sql=sql+"and category=2";
				ps=conn.prepareStatement(sql);
			}else if(table.equals("moim_stat")&&cul==3) {
				sql=sql+"and stat in(1,0)";
				ps=conn.prepareStatement(sql);
			}else if(table.equals("moim_stat")&&cul==4){
				sql=sql+"and stat=0";
				ps=conn.prepareStatement(sql);
			}
			ps=conn.prepareStatement(sql);
			int count=0;

			ps.setInt(1, idx_member);
			rs=ps.executeQuery();
			rs.next();
			count=rs.getInt(1);
			return count==0?1:count;
		}catch(Exception e) {
			e.printStackTrace();
			return 1;
		}finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			}catch(Exception e2) {}
		}
	}
	/**참여중인 모임 총 수 가져오는 메서드*/
	public int getMemTotalCnt(int stat,int idx_member) {
		try {
			conn=com.moim.db.MoimDB.getConn();
			String sql="select count(*) from moim_stat where idx_member=? and stat ";
			if(stat==1) {
				sql=sql+"in(1,0)";
			}else{
				sql=sql+"=0";
			}
			ps=conn.prepareStatement(sql);
			ps.setInt(1, idx_member);
			rs=ps.executeQuery();
			int count=1;
			if(rs.next()) {
				count=rs.getInt(1);
			}
			return count>0?count:1;
		}catch(Exception e) {
			e.printStackTrace();
			return 1;
		}finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			}catch(Exception e2) {}
		}
	}
	/**검색 총 수 가져오기*/
	public int searchTotal(int idx_info,int category,int ls,int cp,String cul,String keyword) {
		try {
			conn=com.moim.db.MoimDB.getConn();
			String sql="select count(*) from moim_noimg where ";
			
			if(cul.equals("전체")) {
				sql=sql+"category=3";
				ps=conn.prepareStatement(sql);
				
			}else if(cul.equals("작성자")) {
				keyword = "%" + keyword.replace(" ", "%") + "%";
				sql=sql+"writer like ? ";
				ps=conn.prepareStatement(sql);
				ps.setString(1, keyword);
			}else if(cul.equals("제목")) {
				keyword = "%" + keyword.replace(" ", "%") + "%";
				sql=sql+"subject like ?";
				ps=conn.prepareStatement(sql);
				ps.setString(1, keyword);
			}
			rs=ps.executeQuery();
			rs.next();
			
			int count=rs.getInt(1);
			return count==0?1:count;
			
		}catch(Exception e) {
			e.printStackTrace();
			return -1;
		}finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			}catch(Exception e2) {}
		}
	}
	/**모임게시판 조회 메서드*/
	public ArrayList<NoimgDTO> getList(int idx_info,int category,int ls,int cp,String cul,String keyword){
		try {
			keyword = "%" + keyword.replace(" ", "%") + "%";
			conn=com.moim.db.MoimDB.getConn();
			int start=(cp-1)*ls+1;
			int end=(cp*ls);
			String sql="select * from(select rownum as rnum,a.*from(select * from moim_noimg where ";
			if(cul.equals("전체")) {
			sql=sql+" idx_info=? and category=?order by ref desc,sunbun asc)a)b where rnum>=? and rnum<=? ";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, idx_info);
			ps.setInt(2, category);
			ps.setInt(3, start);
			ps.setInt(4, end);
			}else if(cul.equals("작성자")) {
			keyword = "%" + keyword.replace(" ", "%") + "%";
			sql=sql+" writer like ? order by ref desc,sunbun asc)a)b where rnum>=? and rnum<=? order by idx desc";
			ps=conn.prepareStatement(sql);
			ps.setString(1, keyword);
			ps.setInt(2, start);
			ps.setInt(3, end);
			}else if(cul.equals("제목")){
			keyword = "%" + keyword.replace(" ", "%") + "%";
			sql=sql+" subject like ? order by ref desc,sunbun asc)a)b where rnum>=? and rnum<=? order by idx desc";
			ps=conn.prepareStatement(sql);
			ps.setString(1, keyword);
			ps.setInt(2, start);
			ps.setInt(3, end);
			}
			rs=ps.executeQuery();
			ArrayList<NoimgDTO> arr=new ArrayList<NoimgDTO>();
			while(rs.next()) {
				int idx=rs.getInt("idx");
				int idx_member=rs.getInt("idx_member");
				String writer=rs.getString("writer");
				String subject=rs.getString("subject");
				String content=rs.getString("content");
				java.sql.Date writedate=rs.getDate("writedate");
				int ref=rs.getInt("ref");
				int lev=rs.getInt("lev");
				int sunbun=rs.getInt("sunbun");
				
				NoimgDTO dto=new NoimgDTO(idx, idx_member, idx_info, category, writer, subject, content, writedate, ref, lev, sunbun);
				arr.add(dto);	
			}
			return arr;
		}catch(Exception e) {
			e.printStackTrace();
			return null;
		}finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			}catch(Exception e2) {}
		}
	}

	
	/**마지막 ref 구하기 관련 메서드*/
	public int getMaxRef() {
		try {
			String sql="select max(ref) from moim_noimg";
			ps=conn.prepareStatement(sql);
			rs=ps.executeQuery();
			int max=0;
			if(rs.next()) {
				max=rs.getInt(1);
			}
			return max;
		}catch(Exception e) {
			e.printStackTrace();
			return 0;
		}finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
			}catch(Exception e2) {}
		}
	}
	
	/**모임게시판 글쓰기 */
	public int writeChat(NoimgDTO dto) {
		try {
			conn=com.moim.db.MoimDB.getConn();
			int maxref=getMaxRef();
			String sql="insert into moim_noimg values(moim_noimg_idx.nextval,?,?,3,?,?,?,sysdate,?,?,?)";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, dto.getIdx_member());
			ps.setInt(2, dto.getIdx_info());
			ps.setString(3, dto.getWriter());
			ps.setString(4, dto.getSubject());
			ps.setString(5, dto.getContent());
			ps.setInt(6, maxref+1);
			ps.setInt(7, dto.getLev());
			ps.setInt(8, dto.getSunbun());
			int count=ps.executeUpdate();
			return count;
		}catch(Exception e) {
			e.printStackTrace();
			return -1;
		}finally {
			try {
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			}catch(Exception e2) {}
		}
	}
	
	/**모임게시판 답변 글쓰기*/
	public int writeReChat(NoimgDTO dto) {
		try {
			conn=com.moim.db.MoimDB.getConn();
			setUpdateSun(dto.getRef(),dto.getSunbun()+1);
			String sql="insert into moim_noimg values(idx.nextval,?,?,3,?,?,?,sysdate,?,?,?)";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, dto.getIdx_member());
			ps.setInt(2, dto.getIdx_info());
			ps.setString(3, dto.getWriter());
			ps.setString(4, dto.getSubject());
			ps.setString(5, dto.getContent());
			ps.setInt(6, dto.getRef());
			ps.setInt(7, dto.getLev()+1);
			ps.setInt(8, dto.getSunbun()+1);
			int count=ps.executeUpdate();
			return count;
		}catch(Exception e) {
			e.printStackTrace();
			return -1;
		}finally {
			try {
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			}catch(Exception e2) {}
		}
	}
	
	/**순서 변경 관련 메서드*/
	public void setUpdateSun(int ref,int sunbun) {
		try {
			String sql="update moim_noimg set sunbun=sunbun+1 where ref=? and sunbun>=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, ref);
			ps.setInt(2, sunbun);
			ps.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(ps!=null)ps.close();
			}catch(Exception e2) {}
		}
	}
	
	/**모임게시판 글 보기 메서드*/ 
	public NoimgDTO getContent(int idx, int category) {
		try {
			conn=com.moim.db.MoimDB.getConn();
			String sql="select * from moim_noimg where idx=? and category=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, idx);
			ps.setInt(2, category);
			rs=ps.executeQuery();
			NoimgDTO dto=null;
			if(rs.next()) {
				int idx_member=rs.getInt("idx_member");
				int idx_info=rs.getInt("idx_info");
				String writer=rs.getString("writer");
				String subject=rs.getString("subject");
				String content=rs.getString("content");
				java.sql.Date writedate=rs.getDate("writedate");
				int ref=rs.getInt("ref");
				int lev=rs.getInt("lev");
				int sunbun=rs.getInt("sunbun");
				dto=new NoimgDTO(idx, idx_member, idx_info, category, writer, subject, content, writedate, ref, lev, sunbun);
				
			}
			return dto;
		}catch(Exception e) {
			e.printStackTrace();
			return null;
		}finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			}catch(Exception e2) {}
		}
	}
	
	/**내가 쓴 후기 삭제 메서드*/
	public int delReview(int idx) {
		try {
			conn=com.moim.db.MoimDB.getConn();
			String sql="delete from moim_review where idx=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, idx);
			int count=ps.executeUpdate();
			return count;
		}catch(Exception e) {
			e.printStackTrace();
			return 0;
		}finally {
			try {
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			}catch(Exception e2) {}
		}
	}
	
	/**내가 쓴 QnA 삭제 메서드*/
	public int delNoimg(int idx) {
		try {
			conn=com.moim.db.MoimDB.getConn();
			String sql="delete from moim_noimg where idx=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, idx);
			int count=ps.executeUpdate();
			return count;
		}catch(Exception e) {
			e.printStackTrace();
			return 0;
		}finally {
			try {
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			}catch(Exception e2) {}
		}
	}

	/**모임게시글 수정 메서드*/
	public int updateNoimg(NoimgDTO dto) {
		try {
			conn=com.moim.db.MoimDB.getConn();
			String sql="update moim_noimg set subject=?,content=? where idx=?";
			ps=conn.prepareStatement(sql);
			ps.setString(1, dto.getSubject());
			ps.setString(2, dto.getContent());
			ps.setInt(3, dto.getIdx());
			int count=ps.executeUpdate();
			return count;
		}catch(Exception e) {
			e.printStackTrace();
			return -2;
		}finally {
			try {
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			}catch(Exception e2) {}
		}
	}
	/**모임게시글 수정용 조회 메서드*/
	public NoimgDTO updateNoimgForm(int idx) {
		try {
			conn=com.moim.db.MoimDB.getConn();
			String sql="select * from moim_noimg where idx=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, idx);
			rs=ps.executeQuery();
			NoimgDTO dto=null;
			if(rs.next()) {
				int idx_member=rs.getInt("idx_member");
				int idx_info=rs.getInt("idx_info");
				int category=rs.getInt("category");
				String writer=rs.getString("writer");
				String subject=rs.getString("subject");
				String content=rs.getString("content");
				java.sql.Date writedate=rs.getDate("writedate");
				int ref=rs.getInt("ref");
				int lev=rs.getInt("lev");
				int sunbun=rs.getInt("sunbun");
				dto=new NoimgDTO(idx, idx_member, idx_info, category, writer, subject, content, writedate, ref, lev, sunbun);
			}
			return dto;
		}catch(Exception e) {
			e.printStackTrace();
			return null;
		}finally {
			try {
				
			}catch(Exception e2) {}
		}
	}
	/**멤버 탈퇴 관련 메서드*/
	public int dropMem(int idx) {
		try {
			conn=com.moim.db.MoimDB.getConn();
			String sql="delete from moim_member where idx=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, idx);
			int count=ps.executeUpdate();
			return count;
		}catch(Exception e){
			e.printStackTrace();
			return -1;
		}finally {
			try {
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			}catch(Exception e2) {}
		}
	}
	

}
