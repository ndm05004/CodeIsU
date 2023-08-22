<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %>
<style>
  .chatting-area {
    border: 1px solid black;
    margin: auto;
  }

  .display-chatting {
    width: 100%;
    height: 300px;
    border: 1px solid black;
    overflow: auto;
    /*스크롤 처럼*/
    list-style: none;
    padding: 10px 10px;
    z-index: 1;
  }

  #inputChatting {
    width: 80%;
    resize: none;
  }

  #send {
    width: 20%;
  }

  .img {
    width: 100%;
    height: 100%;
    position: relative;
    z-index: -100;
  }
</style>

<input type="button" value="입장" name="chatBtn" onclick="openSocket();" />

<input type="text" id="sender" value="${userVo.userNm}" style="display: none" />
<input
  type="text"
  id="profile"
  value="${userVo.userProfile}"
  style="display: none"
/>
<input
  type="hidden"
  id="senderId"
  value="${userVo.userNo}"
  style="display: none"
/>
<input type="hidden" id="projNo" value="${projNo}" style="display: none" />

<section style="background-color: #eee">
  <div class="container py-5">
    <div class="row d-flex justify-content-center">
      <div class="col-md-8 col-lg-6 col-xl-4">
        <div class="card" id="chat1" style="border-radius: 15px">
          <div
            class="card-header d-flex justify-content-between align-items-center p-3 bg-info text-white border-bottom-0"
            style="border-top-left-radius: 15px; border-top-right-radius: 15px"
          ></div>
          <div class="card-body" id="chatting-area">
            <ul class="display-chatting" id="messages"></ul>
          </div>

          <div class="form-outline">
            <div class="row">
              <div class="col-10">
                <textarea
                  class="form-control"
                  id="messageinput"
                  rows="4"
                ></textarea>
              </div>
              <div class="col-2">
                <button id="send" type="button" onclick="send();">
                  보내기
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>

<script type="text/javascript">
  var ws;
  var messages = document.getElementById("messages");
  const sender = document.getElementById("sender").value;
  const senderId = document.getElementById("senderId").value;
  const projNo = document.getElementById("projNo").value;
  const userProfile = document.getElementById("profile").value;

  function openSocket() {
    //웹소켓 객체 만드는 코드
    ws = new WebSocket("ws://localhost:80/chatting");

    ws.onopen = function (event) {
      console.log("채팅방 연결 성공");

      const data = {
        stuNm: sender,
        stuNo: senderId,
        projNo: projNo,
      };

      ws.send(JSON.stringify(data));
    };

    ws.onmessage = function (event) {
      console.log(event.data);
      var data = JSON.parse(event.data);

      writeResponse(data);
    };

    ws.onclose = function (event) {
      //writeResponse("대화 종료");
    };
  }

  function send() {
    let chatContent = $("#messageinput").val();

    let chatSendDate = new Date();

    var text = {
      stuNm: sender,
      stuNo: senderId,
      chatContent: chatContent,
      chatSendDate: chatSendDate,
      projNo: projNo,
      profile: userProfile,
    };

    ws.send(JSON.stringify(text));

    console.log("text", text);

    text = "";
    $("#messageinput").val(text);
  }

  function closeSocket() {
    ws.close();
  }

  function writeResponse(text) {
    console.log("writeResponse");
    let message = "";

    if (senderId == text.stuNo) {
      message += `
      <div class ="row">
        <div class="row pe-0">
          <p class="mb-0 text-end">\${text.stuNm}</p>  
        </div>
        <div class="d-flex flex-row justify-content-end mb-4">
          <div
            class="p-3 me-3 border"
            style="border-radius: 15px; background-color: #fbfbfb"
          >
            <p class="small mb-0">
              \${text.chatContent}
              </p>
          </div>
          <img
            src= \${text.profile}
            alt="avatar 1"
            style="width: 45px; height: 100%"
            class="avatar avatar rounded-circle me-2"
          />
        </div>
      </div>
      `;
    } else {
      message += `
      <div class ="row">
        <div class="row">
          <p class="mb-0">\${text.stuNm}</p>  
        </div>
        <div class="d-flex flex-row justify-content-start mb-4">
          <img
            src=\${text.profile}
            alt="avatar 1"
            style="width: 45px; height: 100%"
            class="avatar avatar rounded-circle me-2"
          />
          <div
            class="p-3 ms-3"
            style="
              border-radius: 15px;
              background-color: rgba(57, 192, 237, 0.2);
            "
          >
            <p class="small mb-0">
              \${text.chatContent}
            </p>
          </div>
          </div>
        </div>

      `;
    }

    console.log("text.chatContent : : : ", text.chatContent);

    if (text.chatContent !== undefined) {
      console.log("text.chatContent console : : : ", text.chatContent);
      messages.innerHTML += message;
    }
    text = "";
  }
</script>
