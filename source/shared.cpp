#include "shared/shared.hpp"

exported_class::exported_class()
    : m_name {"shared"}
{
}

auto exported_class::name() const -> char const*
{
  return m_name.c_str();
}
