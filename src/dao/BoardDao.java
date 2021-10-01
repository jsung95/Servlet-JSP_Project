package dao;

import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import kr.ac.woosuk.computereng.models.AttachFileDTO;
import kr.ac.woosuk.computereng.models.BoardDTO;
import kr.ac.woosuk.computereng.models.UserDTO;

public class BoardDao {
	private String driverName;
	private String url;
	private String username;
	private String password;
	
	public BoardDao() {
		this.driverName = "com.mysql.cj.jdbc.Driver";
		this.url = "jdbc:mysql://127.0.0.1:3306/woosuk?useSSL=false&characterEncoding=UTF-8&serverTimezone=UTC";
		this.username = "root";
		this.password = "1111";
		try {
			Class.forName(this.driverName);
		}
		catch(ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	private Connection getConnection() throws SQLException, ClassNotFoundException {
		return DriverManager.getConnection(this.url, this.username, this.password);
	}
	
	public void insertBoard(BoardDTO board) {
		Connection conn = null;
		Statement stmt = null;
		
		try {
			conn = this.getConnection();
			conn.setAutoCommit(false);
			stmt = conn.createStatement();
			
			String sql = "INSERT INTO BOARD (TITLE, SUB_TITLE, CONTENTS, CREATE_DATE, WRITER) VALUES"
					+"('"+board.getTitle()+"','"
					+board.getSubTitle()+"','"
					+board.getContents()+"','"
					+board.getFormatCreateDate()+"','"
					+board.getWriter()+"')";
			
			stmt.executeUpdate(sql, Statement.RETURN_GENERATED_KEYS);
			ResultSet resultSet = stmt.getGeneratedKeys();
			resultSet.next();
			board.setId(resultSet.getInt(1));
			sql = "INSERT INTO ATTACH_FILE (BOARD_ID, PATH, ORIGINAL_FILE_NAME, SAVE_FILE_NAME) VALUES"
					+"("+board.getId()+",'"
					+board.getAttachFile().getPath()+"','"
					+board.getAttachFile().getOriginalFileName()+"','"
					+board.getAttachFile().getSaveFileName()+"')";
			stmt.executeUpdate(sql);
			conn.commit();
		} catch (SQLException | ClassNotFoundException e) {
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			try {
				if(stmt != null) stmt.close();
				if(conn != null) conn.close();
			} catch(SQLException e) {
				e.printStackTrace();
			}
		}
	}
		
	public ArrayList<BoardDTO> selectBoard() {
			
			ArrayList<BoardDTO> boards = new ArrayList<>();
			
			Connection conn = null;
			Statement stmt = null;
			
			try {
				conn = this.getConnection();
				stmt = conn.createStatement();
	
				String sql = "SELECT ID, TITLE, SUB_TITLE, CONTENTS, CREATE_DATE, WRITER  FROM BOARD";
				ResultSet resultSet = stmt.executeQuery(sql);
				
				while(resultSet.next()) {
					BoardDTO board = new BoardDTO();
					board.setId(resultSet.getInt("ID"));
					board.setTitle(resultSet.getString("TITLE"));
					board.setSubTitle(resultSet.getString("SUB_TITLE"));
					board.setContents(resultSet.getString("CONTENTS"));
					board.setCreateDate(resultSet.getDate("CREATE_DATE"));
					board.setWriter(resultSet.getString("WRITER"));
					
					boards.add(board);
				}
				
				sql = "SELECT * FROM ATTACH_FILE";
				resultSet = stmt.executeQuery(sql);
				
				for(int count = 0; count < boards.size(); count++) {
					while(resultSet.next()) {
						
						AttachFileDTO file = new AttachFileDTO();
						
						if(boards.get(count).getId() == resultSet.getInt("BOARD_ID")) {
							file.setPath(resultSet.getString("PATH"));
							file.setOriginalFileName(resultSet.getString("ORIGINAL_FILE_NAME"));
							file.setSaveFileName(resultSet.getString("SAVE_FILE_NAME"));
							
							boards.get(count).setAttachFile(file);
							break;
						}	
					}
				}
			}
			catch (SQLException | ClassNotFoundException e) {
				e.printStackTrace();
			}
			finally {
				try {
					if(stmt != null) stmt.close();
					if(conn != null) conn.close();
				}
				catch (SQLException e) {
					e.printStackTrace();
				}
			}
			
			return boards;
		}
		
		

	public void updateBoard (BoardDTO board) {
		Connection conn = null;
		Statement stmt = null;
		try {
			conn = this.getConnection();
			stmt = conn.createStatement();
			
			String sql = "UPDATE BOARD SET "
					+ "TITLE='" +board.getTitle()+"', "
					+ "SUB_TITLE='" +board.getSubTitle()+"', "
					+ "CONTENTS='" +board.getContents()+"', "
					+ "CREATE_DATE= NOW()"
					+ "WHERE ID=" +board.getId()+"";
			stmt.executeUpdate(sql);
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		} finally {
			try {
				if(stmt != null) stmt.close();
				if(conn != null) conn.close();
			} catch(SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	
	public void update(BoardDTO board) {
		Connection conn = null;
		Statement stmt = null;
		
		try {
			conn = this.getConnection();
			conn.setAutoCommit(false);
			stmt = conn.createStatement();
			
			String sql = "UPDATE BOARD SET "
					+"TITLE='" + board.getTitle()+"', "
					+"SUB_TITLE='" + board.getSubTitle()+"',"
					+"CONTENTS='" + board.getContents()+"',"
					+"CREATE_DATE= "
					+"WHERE ID =" + board.getId()+"";
			
			stmt.executeUpdate(sql, Statement.RETURN_GENERATED_KEYS);
			ResultSet resultSet = stmt.getGeneratedKeys();
			resultSet.next();
			board.setId(resultSet.getInt(1));
			
			sql = "UPDATE ATTACH_FILE SET "
					+"PATH='" + board.getAttachFile().getPath() +"', "
					+"ORIGINAL_FILE_NAME='" + board.getAttachFile().getOriginalFileName() +"', "
					+"SAVE_FILE_NAME='" + board.getAttachFile().getSaveFileName() +"'"
					+"WHERE BOARD_ID =" + board.getId() +"";
			stmt.executeUpdate(sql);
			conn.commit();
		} catch (SQLException | ClassNotFoundException e) {
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			try {
				if(stmt != null) stmt.close();
				if(conn != null) conn.close();
			} catch(SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	
	public void delBoard (BoardDTO board) {
		Connection conn = null;
		Statement stmt = null;
		try {
			conn = this.getConnection();
			stmt = conn.createStatement();
			
			String sql = "DELETE FROM BOARD WHERE ID="+board.getId()+"";
			stmt.executeUpdate(sql);
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		} finally {
			try {
				if(stmt != null) stmt.close();
				if(conn != null) conn.close();
			} catch(SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	
	
	
	public AttachFileDTO selectFileByID(String ID) {
			
			AttachFileDTO file = new AttachFileDTO();
			
			Connection conn = null;
			Statement stmt = null;
			
			try {
				conn = this.getConnection();
				stmt = conn.createStatement();
	
				String sql = "SELECT BOARD_ID, PATH, SAVE_FILE_NAME FROM ATTACH_FILE WHERE BOARD_ID='"+ID+"'";
				ResultSet resultSet = stmt.executeQuery(sql);
	
				while(resultSet.next()) {
					file.setSaveFileName(resultSet.getString("SAVE_FILE_NAME"));
					file.setPath(resultSet.getString("PATH"));
				}
			} catch (SQLException | ClassNotFoundException e) {
				e.printStackTrace();
			} finally {
				try {
					if(stmt != null) stmt.close();
					if(conn != null) conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			
			return file;
			
		}
	
	public BoardDTO selectBoardByID(String ID) {
		
		BoardDTO board = new BoardDTO();
		
		Connection conn = null;
		Statement stmt = null;
		
		try {
			conn = this.getConnection();
			stmt = conn.createStatement();

			String sql = "SELECT * FROM BOARD WHERE ID='"+ID+"'";
			ResultSet resultSet = stmt.executeQuery(sql);

			while(resultSet.next()) {
				board.setTitle(resultSet.getString("TITLE"));
				board.setSubTitle(resultSet.getString("SUB_TITLE"));
				board.setContents(resultSet.getString("CONTENTS"));
				board.setWriter(resultSet.getString("WRITER"));
				board.setCreateDate(resultSet.getDate("CREATE_DATE"));
				board.setId(resultSet.getInt("ID"));
			}
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		} finally {
			try {
				if(stmt != null) stmt.close();
				if(conn != null) conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return board;
		
	}



}

