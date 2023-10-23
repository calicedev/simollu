import axios from "axios";

const api = axios.create({
  baseURL: "https://simollu.com/api",
  headers: {
    "Content-Type": "application/json",
    Authorization:
      "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiI0M2NjY2U5Yi03MjEwLTRjN2MtYTQzYi1kZWQzOGExZmQxYjUiLCJhdXRob3JpdHkiOlsiUk9MRV9VU0VSIl0sImV4cCI6MTY4NDY0Mjc0OX0.TJ4uXyI0iMQgYywX7cfpeQZeg5RWGQu887Wj-h9SU-8",
  },
});

async function getWaitingList(restaurantSeq: number) {
  try {
    const res = await api.get(`/waiting/restaurant/${restaurantSeq}`);
    console.log(res);
    return res.status;
  } catch (error) {
    console.log(error);
    return error;
  }
}

async function postComeIn(userSeq: String) {
  try {
    const res = await api.post(`/alert/alert`, {
      targetUserSeq: userSeq,
      title: "알림 제목",
      body: "알림 내용",
    });
    console.log(res);
    return res.status;
  } catch (error) {
    console.log(error);
    return error;
  }
}

export default { getWaitingList, postComeIn };
