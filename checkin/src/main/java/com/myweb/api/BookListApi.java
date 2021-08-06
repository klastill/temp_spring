package com.myweb.api;

import java.io.*;
import java.net.*;
import java.util.*;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.google.gson.*;
import com.myweb.domain.BookVO;

public class BookListApi {
	private static Logger logger = LoggerFactory.getLogger(BookListApi.class);
	
	public List<BookVO> makeBookList(JsonArray array) {
		List<BookVO> list = new ArrayList<>();
		for (int i = 0; i < array.size(); i++) {
			JsonObject tempJson = array.get(i).getAsJsonObject();
			String title = tempJson.get("title").getAsString();
			String author = tempJson.get("author").getAsString();
			if (author.equals("")) {
				continue;
			}
			String link = tempJson.get("link").getAsString();
			String desc = tempJson.get("description").getAsString();
			String cover = tempJson.get("cover").getAsString();
			String isbn = tempJson.get("isbn").getAsString();
			int price = tempJson.get("priceSales").getAsInt();
			int review = tempJson.get("customerReviewRank").getAsInt();
			int mile = tempJson.get("mileage").getAsInt();
			if (tempJson.has("bestRank")) {
				int best = tempJson.get("bestRank").getAsInt();
				BookVO book = new BookVO(isbn, price, title, author, link, desc, cover, review, mile, best);
				list.add(book);
//				System.out.println(book);
			} else {
				BookVO book = new BookVO(isbn, price, title, author, link, desc, cover, review, mile);
//				System.out.println(book.getTitle());
				list.add(book);
			}
		}
		
		return list;
	}
	
	String listURL = "http://www.aladin.co.kr/ttb/api/ItemList.aspx?";
	String searchURL = "http://www.aladin.co.kr/ttb/api/ItemSearch.aspx?";
	String luURL = "http://www.aladin.co.kr/ttb/api/ItemLookUp.aspx?";
	String ttbKey = "ttbkey=ttbgyb05011150001";
	String text = "&MaxResults=20&Cover=Big&SearchTarget=Book&output=js&Version=20131101&start=";
	String search = "&QueryType=Keyword&Sort=accuracy&MaxResults=50&Cover=Big&SearchTarget=Book&output=js&Version=20131101&start=";
	
	public JsonArray newArray(int page) {
		String type = "&QueryType=ItemNewSpecial";
		String URL = listURL + ttbKey + type + text + page;
		String responseBody = get(URL);
		JsonParser parser = new JsonParser();
		JsonObject object = (JsonObject) parser.parse(responseBody);
		JsonArray array = object.getAsJsonArray("item");
		return array;
	}
	public JsonArray bestArray(String besttype, int page) {			//메인 화면에 베스트셀러 api 연결
		String query ="&MaxResults=20&Cover=Big&&output=js&Version=20131101&start=";
		String type = "&QueryType=BestSeller";
		String bestType="";
		if(besttype.equals("bestList")) {		//옆에 배너 어떤거 선택했는지, 종합
			bestType="&SearchTarget=Book";	
		}else if(besttype.equals("bestKList")) {		//국내도서
			bestType="&SearchTarget=Book&categoryId=50993";
		}else {		//외국도서
			bestType="&SearchTarget=Foreign";
		}
		String URL = listURL + ttbKey + type + bestType + query + page;
		String responseBody = get(URL);
		JsonParser parser = new JsonParser();
		JsonObject object = (JsonObject) parser.parse(responseBody);
		JsonArray array = object.getAsJsonArray("item");
		return array;
	}
	public JsonArray searchedArray(String keyword, int page) throws UnsupportedEncodingException {
		String kw = URLEncoder.encode(keyword, "UTF-8");
		String URL = searchURL + ttbKey + search + page + "&Query=" + kw;
		String responseBody = get(URL);
		JsonParser parser = new JsonParser();
		JsonObject object = (JsonObject) parser.parse(responseBody);
		JsonArray array = object.getAsJsonArray("item");
		return array;
	}
	public JsonObject lookUp(String id) {
		String query = "&itemIdType=ISBN&output=js&Version=20131101&Cover=Big&ItemId=";
		String URL = luURL + ttbKey + query + id;
		String responseBody = get(URL);
		JsonParser parser = new JsonParser();
		JsonObject object = (JsonObject) parser.parse(responseBody);
		JsonArray array = object.getAsJsonArray("item");
		JsonObject obj = array.get(0).getAsJsonObject();
		return obj;
	}

	private static String get(String apiURL) {
		HttpURLConnection con = connect(apiURL);
		try {
			con.setRequestMethod("GET");
			int responseCode = con.getResponseCode();
			if (responseCode == HttpURLConnection.HTTP_OK) {
				return readBody(con.getInputStream());
			} else {
				return readBody(con.getErrorStream());
			}
		} catch (IOException e) {
			throw new RuntimeException("api call failed");
		} finally {
			con.disconnect();
		}
		
	}
	
	private static String readBody(InputStream body) {
		InputStreamReader streamReader = new InputStreamReader(body);
		try (BufferedReader lineReader = new BufferedReader(streamReader)) {
			StringBuilder responseBody = new StringBuilder();
			String line;
			while ((line = lineReader.readLine()) != null) {
				responseBody.append(line);
			}
			return responseBody.toString();
		} catch (IOException e) {
			throw new RuntimeException("api read failed");
		}
	}

	private static HttpURLConnection connect(String apiURL) {
		try {
			URL url = new URL(apiURL);
			return (HttpURLConnection)url.openConnection();
		} catch (MalformedURLException e) {
			throw new RuntimeException("wrong api url");
		} catch (IOException e) {
			throw new RuntimeException("failed to connect");
		}

	}
}