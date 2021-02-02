import React, { useEffect, useState } from "react";
import { useParams } from "react-router-dom";

import Container from "components/Container";
import PageLoader from "components/PageLoader";
import taskApi from "apis/tasks";
import Logger from "js-logger";

const ShowTask = () => {
  const { id } = useParams();
  const [taskDetails, setTaskDetails] = useState([]);
  const [pageLoading, setPageLoading] = useState(true);

  const fetchTaskDetails = async () => {
    try {
      const response = await taskApi.show(id);
      setTaskDetails(response.data.task);
    } catch (error) {
      Logger.error(error);
    } finally {
      setPageLoading(false);
    }
  };

  useEffect(() => {
    fetchTaskDetails();
  }, []);

  if (pageLoading) {
    return <PageLoader />;
  }

  return (
    <Container>
      <h1 className="pb-3 pl-3 mt-3 mb-3 text-lg leading-5 text-bb-gray border-b border-bb-gray">
        <span>Task Title: </span> {taskDetails?.title}
      </h1>
    </Container>
  );
};

export default ShowTask;