LIBS = -lprotobuf -lpthread `pkg-config --libs opencv4`
CXX_SOURCES = client.cpp messages.pb.cpp
CXX_FLAGS = `pkg-config --cflags opencv4`


client: client.cpp messages.pb.o
	$(CXX) $(CXX_FLAGS) $^ -Wall -Wextra -g -o $@ $(LIBS)

messages.pb.o: messages.pb.cpp
	$(CXX) -c $< -o $@

messages.pb.cpp messages.pb.h:	messages.proto
	@echo "#" compiling $<
	@protoc $< --cpp_out=.
	@mv messages.pb.cc messages.pb.cpp


clean:
	rm -rf messages.pb.cpp messages.pb.h messages.pb.o client
