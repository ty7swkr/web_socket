# WebSocket Parser
* linux에서만 테스트 했음.
* c++17 사용함.

이 소프트웨어 사용으로 발생하는 모든 청구, 손해 또는 기타 책임에 대해
ty7swkr@gmail.com은 아무 책임을 지지 않습니다.

사용법
WebSocket 파싱
```
std::vector<uint8_t> packet;

WebSocket request;
try
{
  request = WebSocket::parse(packet.data(), packet.size());
}
catch (const WebSocketException &e)
{
  // 오류시
  if (e.code == WebSocketException::WRONG_OPCODE || e.code == WebSocketException::UNKNOWN)
  {
    std::cerr << e.what() << std::endl;
    return false;
  }

  // 모두 수신하지 못함.
  return false;
}

switch (request.opcode())
{
  case WebSocket::OPCODE_TEXT: std::cout << request.payload_string_view() << std::endl; break;
  case WebSocket::OPCODE_BINARY: std::cout << request.packet().size() << std::endl; break;
  case WebSocket::OPCODE_CLOSE: std::cout << "close" << std::endl; break;
  case WebSocket::OPCODE_PING: std::cout << "ping" << std::endl; break;
  case WebSocket::OPCODE_PONG: std::cout << "pong" << std::endl; break;
  ....
}
```

WebSocket 패킷 생성
```
#include <web_socket/WebSocket.h>

............
...........
// masking 변수는 클라이언트의 경우 true로, 서버의 경우 false로 해야한다.
/*
class WebSocket
{
public:
  ......
  static WebSocket
  make      (const std::string_view &payload, const bool &masking = false, const bool &last = true);

  static WebSocket
  make      (const uint8_t *payload, const size_t &payload_size, const bool &masking = false, const bool &last = true);

  static WebSocket
  make_ping (const bool &masking = false);

  static WebSocket
  make_pong (const bool &masking = false);

  static WebSocket
  make_close(const std::string &payload = "", const bool &masking = false);

  static WebSocket
  make      (const uint8_t  &op_code,
             const uint8_t  *payload, const size_t &payload_size,
             const bool     &mask_key = false,
             const bool     &last     = true);
  ...
};
*/
std::vector<uint8_t> binary;
............

WebSocket ping = WebSocket::make_ping();
WebSocket req_txt = WebSocket::make("blablablablabla", true); // for client
WebSocket res_bin = WebSocket::make(binary.data(), binary.size()); // for server

WebSocket req_txt2 = WebSocket::make(WebSocket::OPCODE_TEXT, "Hello WebSocket", true, true); // for client
WebSocket res_bin2 = WebSocket::make(WebSocket::OPCODE_BINARY, binary.data(), binary.size(), false, true); // for server

// Sec-Accept-Key 구하기
std::string sec_accept_key = WebSocket::sec_accept_key("oJ+k6v1xAAAEoKTq/XEAAA==" /*Sec-WebSocket-Key*/);
```




