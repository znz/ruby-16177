FROM rubylang/ruby:master-nightly-bionic
RUN echo 'raise %(do not load b.rb)' > b.rb
RUN { \
  echo "autoload :Foo, 'b'"; \
  echo "autoload :Bar, 'b'"; \
  echo "t1 = Thread.new do Foo end"; \
  echo "t2 = Thread.new do Bar end"; \
  echo "t1.join"; \
  echo "t2.join"; \
  } > x.rb
CMD ruby -w --disable=gems -I. x.rb
