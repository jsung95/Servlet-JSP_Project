package kr.ac.woosuk.computereng.controllers;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import dao.AttachFileDao;
import dao.BoardDao;
import dao.UserDao;
import kr.ac.woosuk.computereng.models.AttachFileDTO;
import kr.ac.woosuk.computereng.models.BoardDTO;
import kr.ac.woosuk.computereng.models.BoardVO;
import kr.ac.woosuk.computereng.models.UserDTO;

/**
 * Servlet implementation class FrontController
 */
@MultipartConfig(location="D:/webxml/",
maxFileSize=1024*1024,
maxRequestSize=1024*1024*20,
fileSizeThreshold=1024)
@WebServlet("/controller/*")
public class FrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FrontController() {
        super();
        // TODO Auto-generated constructor stub
    }
    private void checkURL(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	String url = request.getRequestURI();
    	if(url.equals("/Woosuk/controller/LoginCheck")) {//contentEquals
    		this.loginCheck(request, response);
    	}
    	else if(url.equals("/Woosuk/controller/SignUp")) {
    		this.signUp(request, response);
    	}
    	else if(url.equals("/Woosuk/controller/Write_Board")) {
    		this.write_Board(request, response);
    	}
    	else if(url.equals("/Woosuk/controller/ListBoard")) {
    		this.listBoard(request, response);
    	}
    	else if(url.equals("/Woosuk/controller/signout")) {
    		this.signout(request, response);
    	}
    	else if(url.equals("/Woosuk/controller/modifyUser")) {
    		this.modifyUser(request, response);
    	}
    	else if(url.equals("/Woosuk/controller/updateUser")) {
    		this.updateUser(request, response);
    	}
    	else if(url.equals("/Woosuk/controller/modifyBoard")) {
    		this.modifyBoard(request, response);
    	}
    	else if(url.equals("/Woosuk/controller/updateBoard")) {
    		this.updateBoard(request, response);
    	}
    	else if(url.equals("/Woosuk/controller/indexBoard")) {
    		this.indexBoard(request, response);
    	}
    	else if(url.equals("/Woosuk/controller/load_img")) {
    		this.load_img(request, response);
    	}
    	else if(url.equals("/Woosuk/controller/deleteBoard")) {
    		this.deleteBoard(request, response);
    	}
    	else if(url.equals("/Woosuk/controller/boardmore")) {
    		this.boardmore(request, response);
    	}
    }
       
    //����
    private void signUp(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	request.setCharacterEncoding("EUC-KR"); //�ѱ� ���� �̰ɷ� �ذ�
    	
    	String name = request.getParameter("name");
    	String email = request.getParameter("email");
    	String pass1 = request.getParameter("pass1");
		String job = request.getParameter("job");
		String gender = request.getParameter("priority");
		String message = request.getParameter("message");
		
		//response.setCharacterEncoding("UTF-8");
		//response.setContentType("text/html; charset=UTF-8");
		
		UserDTO user = new UserDTO();
		user.setId(name);
		user.setEmail(email);
		user.setPassword(pass1);
		user.setJob(Integer.parseInt(job));
		user.setGender(gender);
		user.setIntroduction(message);
		user.setCreateDate(new Date());
		
		UserDao userDao = new UserDao();
		userDao.insertUser(user);
		
		response.sendRedirect("/Woosuk/signin.jsp");
    }
    
    //�α���üũ
    private void loginCheck(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	String name = request.getParameter("name");
		String pass = request.getParameter("pass");
	
		UserDao userDao = new UserDao();
		UserDTO user = userDao.selectUserByUserName(name);
		
		if(name.equals(user.getId()) && pass.equals(user.getPassword())) {
			HttpSession session = request.getSession();
			session.setAttribute("user", user);
			response.sendRedirect("/Woosuk/controller/indexBoard");
	    	
		}
		else if(!name.equals(user.getId())){
			response.sendRedirect("/Woosuk/signin.jsp?message=FAILUREID");
		}
		
		else if(name.equals(user.getId()) && !pass.equals(user.getPassword())){
			response.sendRedirect("/Woosuk/signin.jsp?message=FAILUREPASS");
		}
    }
    
    //�α׾ƿ�
    private void signout(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	HttpSession session = request.getSession();
    	session.removeAttribute("user");
    	session.invalidate();
    	
    	response.sendRedirect("/Woosuk/signin.jsp");
    }
   
    //ȸ����������
    private void modifyUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	request.setCharacterEncoding("EUC-KR"); //�ѱ� ���� �̰ɷ� �ذ�
    	
    	HttpSession session = request.getSession();
    	UserDTO user = (UserDTO)session.getAttribute("user");
    	
    	if(user == null) {
    		response.sendRedirect("/Woosuk/signin.jsp");
    	}
    	else {
    		UserDao userDao = new UserDao();
    		UserDTO userInfo = userDao.selectUserByUserName(user.getId());
    		request.setAttribute("userInfo", userInfo);
    		RequestDispatcher view = request.getRequestDispatcher("../signup.jsp");
    		view.forward(request, response);
    	}
    }
    private void updateUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	request.setCharacterEncoding("EUC-KR"); //�ѱ� ���� �̰ɷ� �ذ�
    	
    	String name = request.getParameter("name");
    	String email = request.getParameter("email");
    	String pass1 = request.getParameter("pass1");
		String job = request.getParameter("job");
		String gender = request.getParameter("priority");
		String message = request.getParameter("message");
		
		UserDTO user = new UserDTO();
		user.setId(name);
		user.setEmail(email);
		user.setPassword(pass1);
		user.setJob(Integer.parseInt(job));
		user.setGender(gender);
		user.setIntroduction(message);
		user.setCreateDate(new Date());
		
		UserDao userDao = new UserDao();
		userDao.updateUser(user);
		
		response.sendRedirect("/Woosuk/controller/indexBoard");
    }
    
    
    
    //�Խù� ����
    private void modifyBoard(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	request.setCharacterEncoding("EUC-KR"); //�ѱ� ���� �̰ɷ� �ذ�
    	
    	HttpSession session = request.getSession();
    	UserDTO user = (UserDTO)session.getAttribute("user");
    	
    	BoardDao boardDao = new BoardDao();
    	String ID = request.getParameter("id");
    	BoardDTO board = boardDao.selectBoardByID(ID);
    	AttachFileDTO file = boardDao.selectFileByID(ID);
    	
    	if(!user.getId().equals(board.getWriter())) {
    		response.sendRedirect("/Woosuk/controller/ListBoard?message=FAILURE"); //�α���ID�� �ۼ��ڶ� �ٸ��� "������ �����ϴ�" ���
    	}
    	else {
    		request.setAttribute("board", board);
    		request.setAttribute("file", file);
    		RequestDispatcher view = request.getRequestDispatcher("/modify_board.jsp");
    		view.forward(request, response);
    	}
    	

    }
    private void updateBoard(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	request.setCharacterEncoding("EUC-KR"); //�ѱ� ���� �̰ɷ� �ذ�

    	Collection<Part> parts = request.getParts();
        BoardDTO board = new BoardDTO();
        
        HttpSession session = request.getSession();
        UserDTO user = (UserDTO)session.getAttribute("user");

        
		
        for(Part part : parts) {
           if(part.getName().equals("title")) {
              board.setTitle(request.getParameter("title"));
           }
           else if(part.getName().equals("subtitle")) {
              board.setSubTitle(request.getParameter("subtitle"));
           }
           else if(part.getName().equals("contents")) {
              board.setContents(request.getParameter("contents"));
           }
        }
        board.setCreateDate(new Date());
        board.setWriter(user.getId());
        
        String ID = request.getParameter("boardid");
        board.setId(Integer.parseInt(ID));
        
        BoardDao boardDao = new BoardDao();
        boardDao.updateBoard(board);
        
        response.sendRedirect("/Woosuk/controller/ListBoard");
    }
    
    //�Խù� ����
    private void deleteBoard(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	        
    	HttpSession session = request.getSession();
    	UserDTO user = (UserDTO)session.getAttribute("user");
    	
        String ID = request.getParameter("id");
        BoardDao boardDao = new BoardDao();
        BoardDTO board = boardDao.selectBoardByID(ID);
        
		if(!user.getId().equals(board.getWriter())) {
    		response.sendRedirect("/Woosuk/controller/ListBoard?message=FAILURE"); //�α���ID�� �ۼ��ڶ� �ٸ��� "������ �����ϴ�" ���
    	}
		else {
			board.setId(Integer.parseInt(ID));
			boardDao.delBoard(board);
			response.sendRedirect("/Woosuk/controller/ListBoard");
		}
    }
    
    
    //INDEX
    private void indexBoard(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
    	BoardDao board = new BoardDao();
    	ArrayList<BoardDTO> boards = new ArrayList<>();
    	
    	boards = board.selectBoard();
    	
    	request.setAttribute("boards", boards);
		RequestDispatcher view = request.getRequestDispatcher("/index.jsp");
		view.forward(request, response);
		
		
    }  

    //�Խ��� ����Ʈ
    private void listBoard(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
    	BoardDao board = new BoardDao();
    	ArrayList<BoardDTO> boards = new ArrayList<>();
    	
    	boards = board.selectBoard();

		request.setAttribute("boards", boards);
		RequestDispatcher view = request.getRequestDispatcher("/board.jsp");
		view.forward(request, response);
		
		
    }
    
    
    //LearnMore Ŭ����
	private void boardmore(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String ID = request.getParameter("info");
        BoardDao boardDao = new BoardDao();
        BoardDTO board = boardDao.selectBoardByID(ID);
        
    	ArrayList<BoardDTO> boards = new ArrayList<>();
    	boards = boardDao.selectBoard();
        
        request.setAttribute("board", board);
        request.setAttribute("boards", boards);
		RequestDispatcher view = request.getRequestDispatcher("/boardmore.jsp");
		view.forward(request, response);
		
		
		
	}  
    
	
	
    //�Խñ��ۼ�
    private void write_Board(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	request.setCharacterEncoding("EUC-KR"); //�ѱ� ���� �̰ɷ� �ذ�

    	Collection<Part> parts = request.getParts();
        BoardDTO board = new BoardDTO();
        
        HttpSession session = request.getSession();
        UserDTO user = (UserDTO)session.getAttribute("user");

		
        for(Part part : parts) {
           if(part.getName().equals("title")) {
              board.setTitle(request.getParameter("title"));
           }
           else if(part.getName().equals("subtitle")) {
              board.setSubTitle(request.getParameter("subtitle"));
           }
           else if(part.getName().equals("contents")) {
              board.setContents(request.getParameter("contents"));
           }
           else if(part.getName().equals("file")) {
              String path = "D:/webxml/";
              String header = part.getHeader("content-disposition");
              AttachFileDTO attachFile = new AttachFileDTO();
              String strs[] = header.split(";");
              for(String str : strs) {
                 if(str.contains("filename")) {
                    attachFile.setOriginalFileName(this.extractFileNameFromHeader(str, request));
                    attachFile.setSaveFileName(UUID.randomUUID().toString());
                    part.write(attachFile.getSaveFileName());
                    
                    attachFile.setPath(path);
                    
                 }
              }
              board.setAttachFile(attachFile);
           }
        }
        board.setCreateDate(new Date());
        board.setWriter(user.getId());
        
        BoardDao boardDao = new BoardDao();
        boardDao.insertBoard(board);
        
        response.sendRedirect("/Woosuk/controller/ListBoard");

    }
    //����
    private String extractFileNameFromHeader(String header, HttpServletRequest request) {
    	
    	String fileName = header.split("=")[1].replace("\"", "");
    	String seperator = "";
    	if(request.getHeader("user-agent").contains("Trident")) {
    		seperator = "\\";
    	}
    	else {
    		seperator = "/";
    	}
    	int idx = fileName.lastIndexOf(seperator);
    	fileName = fileName.substring(idx+1);
    	
    	return fileName;
    }
    
    //�̹���
	private void load_img(HttpServletRequest request, HttpServletResponse response) throws IOException {
		request.setCharacterEncoding("EUC-KR"); //�ѱ� ���� �̰ɷ� �ذ�
		
		BoardDao boardDao = new BoardDao();
		String ID = request.getParameter("id");
		AttachFileDTO file = boardDao.selectFileByID(ID);
		
		String path = file.getPath();
		String filename = file.getSaveFileName();
		File img = new File(path+filename);
		
		FileInputStream input = new FileInputStream(img);
		ServletOutputStream output = response.getOutputStream();

		byte[] buffer = new byte[1024];
		int data = 0;
		while((data=input.read(buffer))!=-1) {
			output.write(buffer, 0, data);
		}
		
		input.close();
		output.flush();
		output.close();	
	}
	
    
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		this.checkURL(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		this.checkURL(request, response);
	} 

}
