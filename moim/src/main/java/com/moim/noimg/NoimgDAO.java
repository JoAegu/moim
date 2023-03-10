package com.moim.noimg;

import java.sql.*;
import java.util.*;

public class NoimgDAO {
   
   Connection conn;
   PreparedStatement ps;
   ResultSet rs;
   
   public NoimgDAO() {
      // TODO Auto-generated constructor stub
   }
   
   /** 마지막 ref 구하기 관련 메서드 */
   public int getMaxRef() {
      try {
         String sql="select max(ref) from moim_noimg";
         ps=conn.prepareStatement(sql);
         rs=ps.executeQuery();
         
         int max=0;
         if(rs.next()) {
            max=rs.getInt("max(ref)");
         }
         return max;
      } catch (Exception e) {
         e.printStackTrace();
         return 0;
      }finally {
         try {
            if(rs!=null)rs.close();
            if(ps!=null)ps.close();
         } catch (Exception e2) {}
      }
   }
   
   /**QnA 글 작성 관련 메서드*/
   public int setNoimg(int idx_member, int idx_info, String writer, String subject, String content) {
      try {
         conn=com.moim.db.MoimDB.getConn();
         
         int maxref=getMaxRef();
         
         String sql="insert into moim_noimg values(moim_noimg_idx.nextval,?,?,2,?,?,?,sysdate,?,0,0)";
         ps=conn.prepareStatement(sql);
         ps.setInt(1, idx_member);
         ps.setInt(2, idx_info);
         ps.setString(3, writer);
         ps.setString(4, subject);
         ps.setString(5, content);
         ps.setInt(6, maxref+1);
         
         int count=ps.executeUpdate();
         return count;
      } catch (Exception e) {
         e.printStackTrace();
         return -1;
      }finally {
         try {
            if(ps!=null)ps.close();
            if(conn!=null)conn.close();
         } catch (Exception e2) {}
      }
   }

   
   /**QnA 글 순서 변경 관련 메서드*/
   public void setUpdateSunbun(int ref, int sunbun) {
      try {
         String sql="update moim_noimg set sunbun=sunbun+1 where ref=? and sunbun>=? and category=2";
         ps=conn.prepareStatement(sql);
         ps.setInt(1, ref);
         ps.setInt(2, sunbun);
      } catch (Exception e) {
         e.printStackTrace();
      }finally {
         try {
            if(ps!=null)ps.close();
         } catch (Exception e2) {}
      }
   }
   
   /**QnA 답변 작성 관련 메서드*/
   public int setReNoimg(NoimgDTO dto, String writer) {
      try {
         conn=com.moim.db.MoimDB.getConn();
         
         setUpdateSunbun(dto.getRef(),dto.getSunbun()+1);
         
         String sql="insert into moim_noimg values(moim_noimg_idx.nextval,?,?,2,?,?,?,sysdate,?,?,?)";
         ps=conn.prepareStatement(sql);
         ps.setInt(1, dto.getIdx_member());
         ps.setInt(2, dto.getIdx_info());
         ps.setString(3, writer);
         ps.setString(4, dto.getSubject());
         ps.setString(5, dto.getContent());
         ps.setInt(6, dto.getRef());
         ps.setInt(7, dto.getLev()+1);
         ps.setInt(8, dto.getSunbun()+1);
         
         int count=ps.executeUpdate();
         return count;

      } catch (Exception e) {
         e.printStackTrace();
         return -1;
      }finally {
         try {
            if(ps!=null)ps.close();
            if(conn!=null)conn.close();
         } catch (Exception e2) {}
      }
   }
   
   /**총 게시글 수 관련 메서드*/
   public int getQnaTotalCnt(int idx_info) {
      try {
         conn=com.moim.db.MoimDB.getConn();
         String sql="select count(*) from moim_noimg where category=2 and idx_info=?";
         ps=conn.prepareStatement(sql);
         ps.setInt(1, idx_info);
         rs=ps.executeQuery();
         int count=1;
         if(rs.next())
         count=rs.getInt(1);
         return count==0?1:count;
      } catch (Exception e) {
         e.printStackTrace();
         return 1;
      }finally {
         try {
            if(rs!=null)rs.close();
            if(ps!=null)ps.close();
            if(conn!=null)conn.close();
         } catch (Exception e2) {}
      }
   }
   
   /**QnA 글 목록 관련 메서드*/
   public ArrayList<NoimgDTO> getQnaList(int idx_info, int ls, int cp){
      try {
         conn=com.moim.db.MoimDB.getConn();
         
         int start=(cp-1)*ls+1;
         int end=cp*ls;
         
         String sql="select * from "
               + "(select rownum as rnum, a.* from "
               + "(select * from moim_noimg where idx_info=? and category=2 order by ref desc,sunbun asc) a)b "
               + "where rnum>=? and rnum<=?";
         
         ps=conn.prepareStatement(sql);
         ps.setInt(1, idx_info); //ps.setInt(1, idx_info);
         ps.setInt(2, start);
         ps.setInt(3, end);
         rs=ps.executeQuery();
         
         ArrayList<NoimgDTO> arr=new ArrayList<NoimgDTO>();
         while(rs.next()) {
            int idx=rs.getInt("idx");
            int idx_member=rs.getInt("idx_member");
            int category=rs.getInt("category");
            String writer=rs.getString("writer");
            String subject=rs.getString("subject");
            String content=rs.getString("content");
            java.sql.Date writedate=rs.getDate("writedate");
            int ref=rs.getInt("ref");
            int lev=rs.getInt("lev");
            int sunbun=rs.getInt("sunbun");
            
            NoimgDTO dto=new NoimgDTO(idx, idx_member, idx_info, category,writer, subject, content, writedate, ref, lev, sunbun);
            arr.add(dto);
         }

         return arr;
      } catch (Exception e) {
         e.printStackTrace();
         return null;
      }finally {
         try {
            if(rs!=null)rs.close();
            if(ps!=null)ps.close();
            if(conn!=null)conn.close();
         } catch (Exception e2) {}
      }
   } 
   
   /**(공통) 글 수정하기 관련 메서드*/
   public int updateNoimg(NoimgDTO dto) {
	   try {
	          conn=com.moim.db.MoimDB.getConn();
	          String sql="update moim_noimg set subject=?, content=? where idx=?";
	          ps=conn.prepareStatement(sql);
	          ps.setString(1, dto.getSubject());
	          ps.setString(2, dto.getContent());
	          ps.setInt(3, dto.getIdx());
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
   
   /**(공통) 글 삭제 관련 메서드*/
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
         return -1;
      }finally{
         try {
            if(ps!=null)ps.close();
            if(conn!=null)conn.close();
         }catch(Exception e2) {
            
         }
      }
   }
   
   /**(공지사항) 글 작성*/
	public int setNoti(int idx_member,String subject, String content) {
		try {
			conn=com.moim.db.MoimDB.getConn();
			String sql="insert into moim_noimg values(moim_noimg_idx.nextval,?,0,1,'admin',?,?,sysdate,0,0,0)";
			ps=conn.prepareStatement(sql);
			ps.setInt(1,idx_member);
			ps.setString(2, subject);
			ps.setString(3, content);
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
	
	
	
	/**(공지사항)총 게시글 수 검색 기능 추가*/
	public int getNotiTotalCnt( String keyword) {
		try {
			conn=com.moim.db.MoimDB.getConn();
			String sql="select count(*) from moim_noimg where  category = 1 ";
			
			if (!keyword.equals("")) {
				keyword = "%" + keyword.replace(" ", "%") + "%";
				sql = sql + " and subject like ?";
				ps = conn.prepareStatement(sql);
				ps.setString(1, keyword);
				
			} else {
				ps = conn.prepareStatement(sql);
			}
			rs=ps.executeQuery();
			int count = 1;
			if(rs.next());
			count=rs.getInt(1);
			return count==0?1:count;
		} catch (Exception e) {
			e.printStackTrace();
			return 1;
		}finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			} catch (Exception e2) {
				}
			}
		}
	/**(모임, 공지사항)게시판 조회*/
	public ArrayList<NoimgDTO> getList(int idx_info, int category, int ls, int cp){
		try {
			conn=com.moim.db.MoimDB.getConn();
			int start=(cp-1)*ls+1;
			int end=cp*ls;
			String sql="select * from(select rownum as rnum, a.* from (select * from moim_noimg where idx_info=? and category=? order by idx desc, ref desc, sunbun asc)a)b where rnum>=? and rnum<=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, idx_info);
			ps.setInt(2, category);
			ps.setInt(3, start);
			ps.setInt(4, end);
			rs=ps.executeQuery();
			ArrayList<NoimgDTO> arr=new ArrayList<NoimgDTO>();
			if(rs.next()) {
				do {
				int idx=rs.getInt("idx");
				int idx_member=rs.getInt("idx_member");
				String writer=rs.getString("writer");
				String subject=rs.getString("subject");
				String content=rs.getString("content");
				java.sql.Date writedate=rs.getDate("writedate");
				int ref=rs.getInt("ref");
				int lev=rs.getInt("lev");
				int sunbun=rs.getInt("sunbun");
				NoimgDTO dto=new NoimgDTO(idx,idx_member,idx_info,category,writer,subject,content, writedate, ref, lev, sunbun);
				arr.add(dto);
				}while(rs.next());
			}return arr;
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
	
	/**(모임, 공지사항)게시판 조회 기능 추가*/
	public ArrayList<NoimgDTO> getList2( int ls, int cp, String keyword){
		try {
			conn=com.moim.db.MoimDB.getConn();
			int start=(cp-1)*ls+1;
			int end=cp*ls;
			String sql="select * from(select rownum as rnum, a.* from (select * from moim_noimg where  ";
					
			
			if (!keyword.equals("")) {
				keyword = "%" + keyword.replace(" ", "%") + "%";
				sql = sql + "  category=1 and subject like ? order by idx desc, ref desc, sunbun asc)a)b where rnum>=? and rnum<=? ";
				ps = conn.prepareStatement(sql);
				ps.setString(1, keyword);
				ps.setInt(2, start);
				ps.setInt(3, end);
				
			} else {
				sql = sql + " category=1 order by idx desc)a)b where rnum>=? and rnum<=? ";
				ps = conn.prepareStatement(sql);
				ps.setInt(1, start);
				ps.setInt(2, end);
			}
			rs=ps.executeQuery();
			ArrayList<NoimgDTO> arr=new ArrayList<NoimgDTO>();
			if(rs.next()) {
				do {
				int idx=rs.getInt("idx");
				int idx_member=rs.getInt("idx_member");
				String writer=rs.getString("writer");
				String subject=rs.getString("subject");
				String content=rs.getString("content");
				java.sql.Date writedate=rs.getDate("writedate");
				int ref=rs.getInt("ref");
				int lev=rs.getInt("lev");
				int sunbun=rs.getInt("sunbun");
				NoimgDTO dto=new NoimgDTO(idx, idx_member, 0, 1, writer, subject, content, writedate, ref, lev, sunbun);
				arr.add(dto);
				}while(rs.next());
			}return arr;
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
	
/**(공지사항) 본문 보기*/
	public NoimgDTO getContent(int idx) {
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
            
            dto=new NoimgDTO(idx, idx_member, idx_info, category,writer, subject, content, writedate, ref, lev, sunbun);
         }
         return dto;
      } catch (Exception e) {
         e.printStackTrace();
         return null;
      }finally {
         try {
            if(rs!=null)rs.close();
            if(ps!=null)ps.close();
            if(conn!=null)conn.close();
         } catch (Exception e2) {}
      }
   }
   
}