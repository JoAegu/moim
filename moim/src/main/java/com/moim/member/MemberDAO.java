package com.moim.member;

import java.sql.*;
import java.util.*;

public class MemberDAO {
	
	Connection conn;
	PreparedStatement ps;
	ResultSet rs;
	
	public MemberDAO() {
		
	}
	
	/**아이디 중복 체크*/
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
	
	/**회원가입 */
	public int joinMem(MemberDTO dto) {
		try {
			conn=com.moim.db.MoimDB.getConn();   
			String sql="insert into moim_member values(moim_members_idx.nextval,?,?,?,?,?,?,?,sysdate,?)";
			ps=conn.prepareStatement(sql);
			ps.setString(1, dto.getName());
			ps.setString(2, dto.getId());
			ps.setString(3, dto.getPwd());
			ps.setString(4, dto.getEmail());
			ps.setString(5, dto.getLocal());
			ps.setInt(6,dto.getAge());
			ps.setString(7, dto.getHobby());
			ps.setInt(8, dto.getManager());
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
	

}
