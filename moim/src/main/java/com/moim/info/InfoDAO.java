package com.moim.info;

import java.sql.*;
import java.util.*;

import com.moim.noimg.NoimgDTO;

public class InfoDAO {
	Connection conn;
	PreparedStatement ps;
	ResultSet rs;
	
	public InfoDAO() {
		// TODO Auto-generated constructor stub
	}
	
	/**모임글 본문보기 관련 메서드 */
	public NoimgDTO getContent(int idx) {
		try {
			conn=com.moim.db.MoimDB.getConn();
			String sql="select * from moim_noimg where idx=? and category=2";
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
