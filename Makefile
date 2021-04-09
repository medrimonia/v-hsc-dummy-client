LIBS = -lprotobuf -lpthread
CXX_SOURCES = client.cpp messages.pb.cpp


client: client.cpp messages.pb.o
	$(CXX) $^ -o $@ $(LIBS)

messages.pb.o: messages.pb.cpp
	$(CXX) -c $< -o $@

messages.pb.cpp messages.pb.h:	messages.proto
	@echo "#" compiling $<
	@protoc $< --cpp_out=.
	@mv messages.pb.cc messages.pb.cpp


clean:
	rm -rf messages.pb.cpp messages.pb.h messages.pb.o client
