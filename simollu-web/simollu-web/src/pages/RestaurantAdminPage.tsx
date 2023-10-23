import "../styles/main.scss";
import { Button, Grid, Typography } from "@mui/material";
import { grey } from "@mui/material/colors";
import { useEffect, useState } from "react";
import ReplayIcon from "@mui/icons-material/Replay";
import axios from "axios";
import restaurantAdminApi from "../api/restaurantAdminApi";

export default function RestaurantAdminPage() {
  const [currentCount, setCurrentCount] = useState(0);
  const [waitingList, setWaitingList] = useState([
    {
      userSeq: "",
      waitingNo: 0,
      waitingPersonCnt: 0,
    },
  ]);

  const isClickedComeIn = (seq: String) => {
    restaurantAdminApi.postComeIn(seq);
  };

  useEffect(() => {
    // API 호출 및 데이터 설정
    restaurantAdminApi.getWaitingList(124);
  }, []);

  // "waitingSeq": 11,
  // "userSeq": "43ccce9b-7210-4c7c-a43b-ded38a1fd1b5",
  // "restaurantSeq": 124,
  // "waitingPersonCnt": 3,
  // "waitingNo": 3,
  // "restaurantName": "동래정",
  // "waitingStatusRegistDate": "2023-05-16T08:41:53.4800987",
  // "waitingStatusContent": 0
  const handleIncrement = () => {
    setCurrentCount((prevCount: number) => prevCount + 1);
  };

  const handleDecrement = () => {
    setCurrentCount((prevCount: number) => (prevCount > 0 ? prevCount - 1 : 0));
  };

  return (
    <div>
      <div className="restaurant-admin-page">
        <Typography
          sx={{
            fontWeight: "700",
            fontSize: 27,
            display: "block",
            ml: "50px",
            mt: "50px",
          }}
        >
          동래정 선릉직영점
        </Typography>
        <div className="restaurant-admin-page__logo"></div>
      </div>
      <div>
        <div />

        <Typography
          sx={{
            fontWeight: "700",
            fontSize: 25,
            display: "flex",
            justifyContent: "flex-start",
            ml: "50px",
            mt: "30px",
          }}
        >
          가게 현황
        </Typography>
      </div>

      <Typography
        sx={{
          fontWeight: "500",
          fontSize: 18,
          display: "flex",
          justifyContent: "center",
          mt: "50px",
          color: "grey",
        }}
      >
        현재 인원 / 총 인원
      </Typography>

      <div
        style={{
          display: "flex",
          justifyContent: "center",
          alignItems: "center",
          marginTop: "20px",
        }}
      >
        <button
          onClick={handleDecrement}
          style={{
            color: "black",
            border: "1px solid grey",
            borderRadius: "5px",
            padding: "5px 20px",
            marginRight: "20px",
          }}
        >
          -
        </button>
        <span style={{ margin: "0 10px", fontSize: 19 }}>{currentCount}</span>
        <span style={{ margin: "0 10px", fontSize: 19 }}> / </span>
        <span style={{ margin: "0 10px", fontSize: 19 }}>30</span>
        <button
          onClick={handleIncrement}
          style={{
            color: "black",
            border: "1px solid grey",
            borderRadius: "5px",
            padding: "5px 20px",
            marginLeft: "20px",
          }}
        >
          +
        </button>
      </div>
      <div
        style={{
          display: "flex",
          alignItems: "center",
          marginTop: "40px",
          marginLeft: "50px",
        }}
      >
        <Typography
          sx={{
            fontWeight: "700",
            fontSize: 25,
            display: "block",
            justifyContent: "start",
          }}
        >
          웨이팅 현황
        </Typography>
        <ReplayIcon sx={{ ml: "10px" }} />
      </div>
      <div
        style={{
          display: "flex",
          marginTop: "15px",
          marginLeft: "50px",
        }}
      >
        <Grid container>
          <Grid item xs={4}>
            <Typography
              sx={{
                fontWeight: "700",
                fontSize: 15,
                color: "grey",
              }}
            >
              웨이팅 번호
            </Typography>
          </Grid>
          <Grid item xs={4}>
            <Typography
              sx={{
                fontWeight: "700",
                fontSize: 15,
                color: "grey",
              }}
            >
              인원
            </Typography>
          </Grid>
          <Grid item xs={4}></Grid>
        </Grid>
      </div>
      <div
        style={{
          alignItems: "center",
          marginTop: "10px",
          marginLeft: "50px",
        }}
      >
        {waitingList.map((item, index) => (
          <div key={index} style={{ display: "flex", marginTop: "15px" }}>
            <Grid container>
              <Grid item xs={4}>
                <Typography
                  sx={{
                    fontWeight: "700",
                    fontSize: 15,
                    color: "black",
                  }}
                >
                  {item.waitingNo}번
                </Typography>
              </Grid>
              <Grid item xs={4}>
                <Typography
                  sx={{
                    fontWeight: "700",
                    fontSize: 15,
                    color: "black",
                  }}
                >
                  {item.waitingPersonCnt}명
                </Typography>
              </Grid>
              <Grid item xs={4}>
                <button
                  onClick={() => isClickedComeIn(item.userSeq)}
                  style={{
                    backgroundColor: "#F6D000",
                    color: "white",
                    border: "none",
                    borderRadius: "5px",
                    padding: "5px 20px",
                    marginRight: "20px",
                  }}
                >
                  입장
                </button>
              </Grid>
            </Grid>
          </div>
        ))}
      </div>
    </div>
  );
}
