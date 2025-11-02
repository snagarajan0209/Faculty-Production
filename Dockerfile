FROM faculty-frontend:latest AS builder

FROM faculty-backend:latest
COPY --from=builder /home/periyaruniversity/Faculty-Frontend/dist /home/periyaruniversity/Faculty-Backend/build
