import React, { useState, useEffect } from 'react';
import { FaSearch, FaStar, FaTrash, FaReply } from 'react-icons/fa';
import api from '../../services/api';
import './ReviewManagement.css';

const ReviewManagement = () => {
  const [reviews, setReviews] = useState([]);
  const [loading, setLoading] = useState(true);
  const [searchTerm, setSearchTerm] = useState('');
  const [ratingFilter, setRatingFilter] = useState('ALL');

  useEffect(() => {
    fetchReviews();
  }, []);

  const fetchReviews = async () => {
    try {
      setLoading(true);
      const response = await api.get('/reviews');
      setReviews(response.data);
    } catch (error) {
      console.error('Error fetching reviews:', error);
    } finally {
      setLoading(false);
    }
  };

  const handleDelete = async (id) => {
    if (window.confirm('Are you sure you want to delete this review?')) {
      try {
        await api.delete(`/reviews/${id}`);
        fetchReviews();
      } catch (error) {
        console.error('Error deleting review:', error);
      }
    }
  };

  const filteredReviews = reviews.filter(review => {
    const matchesSearch = review.userName?.toLowerCase().includes(searchTerm.toLowerCase()) ||
                         review.hotelName?.toLowerCase().includes(searchTerm.toLowerCase()) ||
                         review.comment?.toLowerCase().includes(searchTerm.toLowerCase());
    const matchesRating = ratingFilter === 'ALL' || review.rating === parseInt(ratingFilter);
    return matchesSearch && matchesRating;
  });

  const renderStars = (rating) => {
    return Array(5).fill(0).map((_, index) => (
      <FaStar
        key={index}
        className={index < rating ? 'star-filled' : 'star-empty'}
      />
    ));
  };

  if (loading) {
    return <div className="loading">Loading reviews...</div>;
  }

  return (
    <div className="review-management">
      <div className="page-header">
        <h1>Review Management</h1>
      </div>

      <div className="filters-bar">
        <div className="search-box">
          <FaSearch />
          <input
            type="text"
            placeholder="Search reviews..."
            value={searchTerm}
            onChange={(e) => setSearchTerm(e.target.value)}
          />
        </div>

        <div className="filter-group">
          <select value={ratingFilter} onChange={(e) => setRatingFilter(e.target.value)}>
            <option value="ALL">All Ratings</option>
            <option value="5">5 Stars</option>
            <option value="4">4 Stars</option>
            <option value="3">3 Stars</option>
            <option value="2">2 Stars</option>
            <option value="1">1 Star</option>
          </select>
        </div>
      </div>

      <div className="review-stats">
        <div className="stat-card">
          <h3>{reviews.length}</h3>
          <p>Total Reviews</p>
        </div>
        <div className="stat-card">
          <h3>{(reviews.reduce((acc, r) => acc + r.rating, 0) / reviews.length).toFixed(1)}</h3>
          <p>Average Rating</p>
        </div>
        <div className="stat-card">
          <h3>{reviews.filter(r => r.rating === 5).length}</h3>
          <p>5-Star Reviews</p>
        </div>
        <div className="stat-card">
          <h3>{reviews.filter(r => r.rating <= 2).length}</h3>
          <p>Low Ratings</p>
        </div>
      </div>

      <div className="review-list">
        {filteredReviews.map((review) => (
          <div key={review.id} className="review-card">
            <div className="review-header">
              <div className="reviewer-info">
                <div className="reviewer-avatar">
                  {review.userName?.charAt(0) || 'U'}
                </div>
                <div>
                  <h4>{review.userName}</h4>
                  <p className="review-date">
                    {new Date(review.createdAt).toLocaleDateString()}
                  </p>
                </div>
              </div>
              <div className="review-rating">
                {renderStars(review.rating)}
              </div>
            </div>

            <div className="review-hotel">
              <strong>{review.hotelName}</strong>
            </div>

            <div className="review-comment">
              <p>{review.comment}</p>
            </div>

            {review.imageUrl && (
              <div className="review-image">
                <img src={review.imageUrl} alt="Review" />
              </div>
            )}

            <div className="review-actions">
              <button className="btn-icon btn-reply" title="Reply">
                <FaReply /> Reply
              </button>
              <button
                className="btn-icon btn-delete"
                title="Delete"
                onClick={() => handleDelete(review.id)}
              >
                <FaTrash /> Delete
              </button>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
};

export default ReviewManagement;